import 'package:flutter/material.dart';
import 'package:trivia_game/features/question/components/answer_button.dart';


class TrueFalseAnswerItem extends StatelessWidget {
  final String correctAnswer;
  final Function(bool value) onTap;
  const TrueFalseAnswerItem(
      {super.key, required this.onTap, required this.correctAnswer});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnswerButton(
          onTap: () => onTap(correctAnswer == 'True'),
          answer: 'True',
          color: const Color(0xff11d08d),
        ),
        AnswerButton(
          onTap: () => onTap(correctAnswer == 'False'),
          answer: 'False',
          color: const Color(0xfff75554),
        ),
      ],
    );
  }
}
