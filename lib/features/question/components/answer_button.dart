import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_game/features/home/cubit/home_cubit.dart';

import '../../../shared/supplements/constants/theme_globals.dart';

class AnswerButton extends StatelessWidget {
  final String answer;
  final Color color;
  final Function() onTap;
  const AnswerButton(
      {super.key,
      required this.answer,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HomeCubit>().click();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 10,
              offset: Offset(0, 10),
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Color(0x4C000000),
              blurRadius: 2,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        constraints: const BoxConstraints(minHeight: 160, minWidth: 160),
        child: Center(
            child: Text(
          answer,
          style: titleMedium.copyWith(color: whiteColor),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
