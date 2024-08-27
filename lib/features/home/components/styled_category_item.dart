import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_game/features/challenge_level/view.dart';
import 'package:trivia_game/features/home/cubit/home_cubit.dart';
import 'package:trivia_game/shared/foundation/models/restful_response/category_response.dart';

import '../../../shared/supplements/constants/theme_globals.dart';

class StyledCategoryItem extends StatelessWidget {
  final Widget icon;

  final TriviaCategory category;
  const StyledCategoryItem({
    super.key,
    required this.icon,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.read<HomeCubit>().pause();
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChallengeLevelScreen(
            category: category,
          ),
        ));
        context.read<HomeCubit>().resume();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: category.color,
          borderRadius: BorderRadius.circular(8),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 16),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  category.name,
                  style: bodyLarge.copyWith(
                      color: whiteColor, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
