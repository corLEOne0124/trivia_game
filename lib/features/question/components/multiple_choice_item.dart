import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trivia_game/features/question/components/answer_button.dart';

class MultipleChoiceItem extends StatelessWidget {
  final List<String> answers;
  final String correctAnswer;
  final Function(bool correct) onTap;
  const MultipleChoiceItem(
      {super.key,
      required this.answers,
      required this.correctAnswer,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final newList = [...answers, correctAnswer]..shuffle();
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      childAspectRatio:
          kIsWeb ? ((MediaQuery.of(context).size.width < 500) ? 1.4 : 3) : 1,
      padding: EdgeInsets.zero,
      mainAxisSpacing: 16,
      children: [
        AnswerButton(
          onTap: () => onTap(newList.elementAt(0) == correctAnswer),
          answer: newList.elementAt(0),
          color: const Color(0xff11d08d),
        ),
        AnswerButton(
          onTap: () => onTap(newList.elementAt(1) == correctAnswer),
          answer: newList.elementAt(1),
          color: const Color(0xfff75554),
        ),
        AnswerButton(
          onTap: () => onTap(newList.elementAt(2) == correctAnswer),
          answer: newList.elementAt(2),
          color: const Color(0xff3679fe),
        ),
        AnswerButton(
          onTap: () => onTap(newList.elementAt(3) == correctAnswer),
          answer: newList.elementAt(3),
          color: const Color(0xffff981f),
        ),
      ],
    );
  }
}
