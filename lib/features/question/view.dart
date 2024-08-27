// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:trivia_game/features/home/cubit/home_cubit.dart';
import 'package:trivia_game/features/home/view.dart';
import 'package:trivia_game/features/question/components/congrats_item.dart';
import 'package:trivia_game/features/question/components/multiple_choice_item.dart';
import 'package:trivia_game/features/question/components/true_false_answer_item.dart';
import 'package:trivia_game/shared/components/styled/styled_alert_dialog.dart';
import 'package:trivia_game/shared/foundation/models/restful_response/category_response.dart';
import 'package:trivia_game/shared/supplements/constants/theme_globals.dart';

class QuestionScreen extends StatefulWidget {
  final TriviaCategory category;
  final String level;

  const QuestionScreen(
      {super.key, required this.category, required this.level});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final PageController _controller = PageController();

  @override
  void initState() {
    context
        .read<HomeCubit>()
        .fetchQuestions(categoryId: widget.category.id, level: widget.level);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String convertHtmlToString(value) {
    var unescape = HtmlUnescape();
    return unescape.convert(value);
  }

  Color getRemainingColor() {
    if (context.read<HomeCubit>().leftTime >= 45) {
      return Colors.green;
    } else if (context.read<HomeCubit>().leftTime >= 15) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<HomeCubit>(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) async {
          final result = context.read<HomeCubit>().currentUserPoint;
          if (state is GameIsOver) {
            await Future.delayed(const Duration(milliseconds: 500));
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CongratsScreen(
                  userResult: result,
                ),
              ),
            );
            context.read<HomeCubit>().clear();
          }
          if (state is TimeIsOver) {
            await showDialog(
              context: context,
              useSafeArea: true,
              builder: (c) {
                return const StyledAlertDialog(
                  message: 'Time is over',
                );
              },
            );
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false);
          }
        },
        builder: (context, state) {
          if (state is QuestionsFetched) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                leadingWidth: 60,
                leading: StreamBuilder<int>(
                    initialData: 0,
                    stream: context.read<HomeCubit>().currentQuestion$,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16),
                        child: Text(
                          '${snapshot.data}/${state.questions.length}',
                          style: titleMedium.copyWith(
                              color: blackColor, fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
                actions: [
                  StreamBuilder<int>(
                      initialData: 0,
                      stream: context.read<HomeCubit>().currentUserPoint$,
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            '${snapshot.data}',
                            style: titleMedium.copyWith(
                                color: blackColor, fontWeight: FontWeight.bold),
                          ),
                        );
                      })
                ],
                title: Text(
                  widget.category.name,
                  style: titleLarge.copyWith(
                      color: blackColor, fontWeight: FontWeight.w500),
                ),
              ),
              body: Column(
                children: [
                  Container(
                    width: 300,
                    height: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.transparent),
                    child: SizedBox.expand(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: StreamBuilder<int>(
                            initialData: 60,
                            stream: context.read<HomeCubit>().leftTime$,
                            builder: (context, snapshot) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.linear,
                                width: (context.read<HomeCubit>().leftTime /
                                        context.read<HomeCubit>().totalTime) *
                                    300,
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  gradient: LinearGradient(
                                    colors: [
                                      getRemainingColor(),
                                      getRemainingColor(),
                                      Colors.white,
                                      Colors.white,
                                    ],
                                    stops: [
                                      1.0,
                                      1.0,
                                      (context.read<HomeCubit>().leftTime /
                                          context.read<HomeCubit>().totalTime),
                                      (context.read<HomeCubit>().leftTime /
                                          context.read<HomeCubit>().totalTime),
                                    ],
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: PageView.builder(
                        clipBehavior: Clip.none,
                        controller: _controller,
                        itemCount: state.questions.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final question = state.questions.elementAt(index);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                convertHtmlToString(question.question),
                                textAlign: TextAlign.center,
                                style: headlineLarge.copyWith(
                                    color: blackColor, fontSize: 28),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Spacer(),
                                    if (question.type.index == 0)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 64.0),
                                        child: TrueFalseAnswerItem(
                                          correctAnswer: question.correctAnswer,
                                          onTap: (value) {
                                            if (value) {
                                              showTopSnackBar(
                                                Overlay.of(context),
                                                const CustomSnackBar.success(
                                                  message:
                                                      "Jingle all the way! You nailed it!",
                                                ),
                                                animationDuration:
                                                    const Duration(
                                                        milliseconds: 500),
                                                displayDuration: const Duration(
                                                    milliseconds: 200),
                                              );
                                              context
                                                  .read<HomeCubit>()
                                                  .updateCurrentUserPoint(context
                                                          .read<HomeCubit>()
                                                          .currentUserPoint +
                                                      1);
                                            } else {
                                              showTopSnackBar(
                                                Overlay.of(context),
                                                const CustomSnackBar.error(
                                                  message:
                                                      "Snow way! Give it another go.",
                                                ),
                                                animationDuration:
                                                    const Duration(
                                                        milliseconds: 500),
                                                displayDuration: const Duration(
                                                    milliseconds: 200),
                                              );
                                            }
                                            context
                                                .read<HomeCubit>()
                                                .updateCurrentQuestion(
                                                    index + 1);
                                            _controller.animateToPage(index + 1,
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                curve: Curves.linear);
                                          },
                                        ),
                                      )
                                    else
                                      (kIsWeb &&
                                              MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  1200 &&
                                              MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  500)
                                          ? Expanded(
                                              child: MultipleChoiceItem(
                                                  onTap: (value) {
                                                    if (value) {
                                                      showTopSnackBar(
                                                        Overlay.of(context),
                                                        const CustomSnackBar
                                                            .success(
                                                          message:
                                                              "Jingle all the way! You nailed it!",
                                                        ),
                                                        animationDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        displayDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                      );
                                                      context
                                                          .read<HomeCubit>()
                                                          .updateCurrentUserPoint(context
                                                                  .read<
                                                                      HomeCubit>()
                                                                  .currentUserPoint +
                                                              1);
                                                    } else {
                                                      showTopSnackBar(
                                                        Overlay.of(context),
                                                        const CustomSnackBar
                                                            .error(
                                                          message:
                                                              "Snow way! Give it another go.",
                                                        ),
                                                        animationDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        displayDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                      );
                                                    }
                                                    context
                                                        .read<HomeCubit>()
                                                        .updateCurrentQuestion(
                                                            index + 1);
                                                    _controller.animateToPage(
                                                        index + 1,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        curve: Curves.linear);
                                                  },
                                                  answers:
                                                      question.incorrectAnswers,
                                                  correctAnswer:
                                                      question.correctAnswer),
                                            )
                                          : ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxHeight: kIsWeb
                                                      ? MediaQuery.of(context)
                                                                  .size
                                                                  .width <
                                                              500
                                                          ? 300
                                                          : 500
                                                      : 400),
                                              child: MultipleChoiceItem(
                                                  onTap: (value) {
                                                    if (value) {
                                                      showTopSnackBar(
                                                        Overlay.of(context),
                                                        const CustomSnackBar
                                                            .success(
                                                          message:
                                                              "Jingle all the way! You nailed it!",
                                                        ),
                                                        animationDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        displayDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                      );
                                                      context
                                                          .read<HomeCubit>()
                                                          .updateCurrentUserPoint(context
                                                                  .read<
                                                                      HomeCubit>()
                                                                  .currentUserPoint +
                                                              1);
                                                    } else {
                                                      showTopSnackBar(
                                                        Overlay.of(context),
                                                        const CustomSnackBar
                                                            .error(
                                                          message:
                                                              "Snow way! Give it another go.",
                                                        ),
                                                        animationDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        displayDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                      );
                                                    }
                                                    context
                                                        .read<HomeCubit>()
                                                        .updateCurrentQuestion(
                                                            index + 1);
                                                    _controller.animateToPage(
                                                        index + 1,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        curve: Curves.linear);
                                                  },
                                                  answers:
                                                      question.incorrectAnswers,
                                                  correctAnswer:
                                                      question.correctAnswer),
                                            ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Scaffold(
            backgroundColor: Color(0xff487eef),
            body: Center(
              child: CircularProgressIndicator(
                color: whiteColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
