import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:trivia_game/shared/supplements/constants/theme_globals.dart';

class ChallengeLevelItem extends StatelessWidget {
  final LinearGradient color;
  final String level;
  final String title;
  final Widget icon;
  final Function onTap;
  const ChallengeLevelItem(
      {super.key,
      required this.color,
      required this.level,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 120,
        padding: kIsWeb
            ? const EdgeInsets.symmetric(horizontal: 32, vertical: 24)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 3,
              offset: Offset(0, 1),
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Color(0x4C000000),
              blurRadius: 2,
              offset: Offset(0, 1),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  level,
                  style: bodyMedium.copyWith(color: whiteColor),
                ),
                Text(
                  title,
                  style: titleMedium.copyWith(color: whiteColor),
                ),
              ],
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
