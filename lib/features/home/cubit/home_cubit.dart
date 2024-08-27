import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trivia_game/features/home/repository.dart';
import 'package:trivia_game/shared/foundation/helpers/functions/debugging_helpers.dart';
import 'package:trivia_game/shared/foundation/models/restful_response/category_response.dart';
import 'package:trivia_game/shared/foundation/models/restful_response/question_response.dart';
import 'package:trivia_game/shared/foundation/services/secure_storage_service.dart';

import '../../../shared/foundation/helpers/functions/locator.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  AudioPlayer? _player;
  AudioPlayer? _player2;

  TriviaRepository get _triviaRepository => locator<TriviaRepository>();
  SecureStorageService get _secureStorageService =>
      locator<SecureStorageService>();

  final _currentQuestionCon = BehaviorSubject<int>.seeded(0);
  int get currentQuestion => _currentQuestionCon.value;
  Stream<int> get currentQuestion$ => _currentQuestionCon.stream;
  void updateCurrentQuestion(int value) {
    if (value == 10) {
      cancelTimer();

      emit(GameIsOver());
    }
    _currentQuestionCon.add(value);
  }

  final _currentUserPointCon = BehaviorSubject<int>.seeded(0);
  int get currentUserPoint => _currentUserPointCon.value;
  Stream<int> get currentUserPoint$ => _currentUserPointCon.stream;
  void updateCurrentUserPoint(int value) => _currentUserPointCon.add(value);

  final _leftTimeCon = BehaviorSubject<int>.seeded(60);
  int get leftTime => _leftTimeCon.value;
  Stream<int> get leftTime$ => _leftTimeCon.stream;
  void updateLeftTime(int value) => _leftTimeCon.add(value);

  final _triviaCategoriesCon = BehaviorSubject<List<TriviaCategory>>.seeded([]);
  List<TriviaCategory> get triviaCategories => _triviaCategoriesCon.value;
  Stream<List<TriviaCategory>> get triviaCategories$ =>
      _triviaCategoriesCon.stream;
  void updateTriviaCategories(List<TriviaCategory> value) =>
      _triviaCategoriesCon.add(value);
  int totalTime = 60;
  int currentTime = 60;
  Timer? timer;
  Future<void> fetchCategories() async {
    try {
      emit(HomeLoading());

      final result = await _triviaRepository.getCategoryList();
      final categories = result.triviaCategories.getRange(0, 10);

      if (categories.isNotEmpty) {
        final updated = categories.map((e) {
          late LinearGradient color;
          late String icon;
          String name = e.name;
          if (e.name.contains('Entertainment: ')) {
            name = e.name.replaceAll('Entertainment: ', "");
          }
          if (e.name.contains('Science: ')) {
            name = e.name.replaceAll('Science: ', "");
          }

          switch (e.id) {
            case 9:
              color = const LinearGradient(colors: [
                Color(0xffec719a),
                Color(0xffec8a6d),
              ]);
              icon = 'general_knowledge';
            case 10:
              color = const LinearGradient(colors: [
                Color(0xff5274ed),
                Color(0xff10b0fb),
              ]);
              icon = 'books';
            case 11:
              color = const LinearGradient(colors: [
                Color(0xff5274ed),
                Color(0xff10b0fb),
              ]);
              icon = 'movie';
            case 12:
              color = const LinearGradient(colors: [
                Color(0xff799F0C),
                Color(0xffACBB78),
              ]);
              icon = 'music';
            case 13:
              color = const LinearGradient(colors: [
                Color(0xffa88fd4),
                Color(0xffe6b6e5),
              ]);
              icon = 'theatre';
            case 14:
              color = const LinearGradient(colors: [
                Color(0xffacb6e5),
                Color(0xff86fde8),
              ]);
              icon = 'television';
            case 15:
              color = const LinearGradient(colors: [
                Color(0xff2C3E50),
                Color(0xff4CA1AF),
              ]);
              icon = 'game';
            case 16:
              color = const LinearGradient(colors: [
                Color(0xffFF5F6D),
                Color(0xffFFC371),
              ]);
              icon = 'board_game';
            case 17:
              color = const LinearGradient(colors: [
                Color(0xffa80077),
                Color(0xff66ff00),
              ]);
              icon = 'science';
            case 18:
              color = const LinearGradient(colors: [
                Color(0xffE0EAFC),
                Color(0xffCFDEF3),
              ]);
              icon = 'computer';
              break;
            default:
          }

          return e.copyWith(
            name: name,
            color: color,
            icon: icon,
          );
        }).toList();
        final updatedList = result.copyWith(triviaCategories: updated);
        updateTriviaCategories(updatedList.triviaCategories);
        emit(HomeCategoriesFetched());
      }
    } catch (e, s) {
      logError(e, s);
    }
  }

  Future<void> getSessionToken() async {
    try {
      emit(HomeLoading());
      final result = await _triviaRepository.getSessionToken();
      await _secureStorageService.saveToken(result.token);
    } catch (e, s) {
      logError(e, s);
    }
  }

  Future<void> fetchQuestions({
    int amount = 10,
    required int categoryId,
    required String level,
  }) async {
    try {
      emit(HomeLoading());
      final result = await _triviaRepository.getQuestions(
          amount: amount,
          categoryId: categoryId,
          level: level,
          token: await _secureStorageService.token);
      updateLeftTime(60);
      currentTime = 60;

      startTimer();

      emit(QuestionsFetched(questions: result.results));
    } catch (e, s) {
      logError(e, s);
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (currentTime <= 0) {
        t.cancel();
        emit(TimeIsOver());
      } else {
        currentTime--;
        updateLeftTime(currentTime);
      }
    });
  }

  void cancelTimer() {
    timer?.cancel();
  }

  void clear() {
    updateCurrentQuestion(0);
    updateCurrentUserPoint(0);

    updateLeftTime(60);
    currentTime = 60;
  }

  void play() async {
    if (_player != null) {
      _player!.resume();
    } else {
      _player = AudioPlayer();
      await _player!.setReleaseMode(ReleaseMode.loop);
      await _player!.setSourceAsset('audio/christmas.mp3');
      await _player!.play(AssetSource('audio/christmas.mp3'));
    }
  }

  void click() async {
    _player2 = AudioPlayer();
    await _player2!.setReleaseMode(ReleaseMode.release);
    await _player2!.play(AssetSource('audio/click.mp3'));
  }

  Future<void> pause() async {
    await _player!.pause();
  }

  Future<void> resume() async {
    await _player!.resume();
  }

  @override
  Future<void> close() async {
    await _player!.stop();
    await _player!.dispose();
    return super.close();
  }
}
