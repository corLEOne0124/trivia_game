part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeCategoriesFetched extends HomeState {}

final class TimeIsOver extends HomeState {}
final class GameIsOver extends HomeState {}


final class QuestionsFetched extends HomeState {
  final List<Result> questions;
  const QuestionsFetched({required this.questions});

  @override
  List<Object> get props => [questions];
}
