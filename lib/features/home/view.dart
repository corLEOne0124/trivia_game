import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trivia_game/features/home/components/styled_category_item.dart';
import 'package:trivia_game/features/home/cubit/home_cubit.dart';
import 'package:trivia_game/features/snowflake/view.dart';
import 'package:trivia_game/shared/supplements/constants/theme_globals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().resume();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                "Let's play",
                style: headlineMedium.copyWith(
                    color: const Color(0xfff35b78),
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GridView.count(
                      crossAxisCount: kIsWeb
                          ? MediaQuery.of(context).size.width < 1000
                              ? 2
                              : 4
                          : 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      padding: const EdgeInsets.only(bottom: 32),
                      children: [
                        ...context.read<HomeCubit>().triviaCategories.map(
                              (e) => StyledCategoryItem(
                                icon: SvgPicture.asset(
                                  'assets/vector/${e.icon}.svg',
                                  width: 50,
                                ),
                                category: e,
                              ),
                            ),
                      ],
                    ),
                    const Positioned.fill(
                      child: IgnorePointer(
                        ignoring: true,
                        child: SnowWidget(
                          isRunning: true,
                          totalSnow: 50,
                          speed: 0.2,
                          maxRadius: 8,
                          snowColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() async {
    super.dispose();
  }
}
