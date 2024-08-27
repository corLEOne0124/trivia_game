import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trivia_game/features/challenge_level/components/challenge_level_item.dart';
import 'package:trivia_game/features/question/view.dart';
import 'package:trivia_game/shared/foundation/models/restful_response/category_response.dart';
import 'package:trivia_game/shared/supplements/constants/theme_globals.dart';

class ChallengeLevelScreen extends StatelessWidget {
  final TriviaCategory category;
  const ChallengeLevelScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: kIsWeb
            ? null
            : InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xfff35b78),
                ),
              ),
        elevation: 0,
        forceMaterialTransparency: true,
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        foregroundColor: whiteColor,
        shadowColor: whiteColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Begin your journey",
                style: headlineMedium.copyWith(
                  fontSize: 28,
                  color: const Color(0xfff35b78),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              ChallengeLevelItem(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        QuestionScreen(category: category, level: 'easy'),
                  ));
                },
                color: const LinearGradient(colors: [
                  Color(0xffE55D87),
                  Color(0xff5FC3E4),
                ]),
                level: 'Easy',
                title: 'Boarding Basics',
                icon: SvgPicture.asset(
                  'assets/vector/helicopter.svg',
                  width: 60,
                ),
              ),
              const SizedBox(height: 16),
              ChallengeLevelItem(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        QuestionScreen(category: category, level: 'medium'),
                  ));
                },
                color: const LinearGradient(colors: [
                  Color(0xffFBD786),
                  Color(0xfff7797d),
                ]),
                level: 'Medium',
                title: 'Cockpit Challenge',
                icon: SvgPicture.asset(
                  'assets/vector/plane.svg',
                  width: 60,
                ),
              ),
              const SizedBox(height: 16),
              ChallengeLevelItem(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        QuestionScreen(category: category, level: 'hard'),
                  ));
                },
                color: const LinearGradient(colors: [
                  Color(0xffbc4e9c),
                  Color(0xfff80759),
                ]),
                level: 'Hard',
                title: 'Turbulence Test',
                icon: SvgPicture.asset(
                  'assets/vector/rocket.svg',
                  width: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
