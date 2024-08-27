import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_game/features/home/cubit/home_cubit.dart';
import 'package:trivia_game/features/home/view.dart';
import 'package:trivia_game/shared/foundation/models/restful_response/category_response.dart';
import 'package:trivia_game/shared/supplements/constants/theme_globals.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff487eef),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Text(
              'Trivia',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 60,
                  letterSpacing: 8,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = whiteColor),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 200),
              child: Text(
                'by Ruslan Hajiyev',
                textAlign: TextAlign.center,
                style: bodyMedium.copyWith(color: whiteColor),
              ),
            ),
            const Spacer(),
            StreamBuilder<List<TriviaCategory>>(
                stream: context.read<HomeCubit>().triviaCategories$,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return InkWell(
                      splashFactory: NoSplash.splashFactory,
                      splashColor: Colors.transparent,
                      onTap: () {
                        context.read<HomeCubit>().play();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false);
                      },
                      child: Center(
                        child: Text(
                          "Let's start",
                          style: titleLarge.copyWith(
                              color: whiteColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                  return const Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(
                      color: whiteColor,
                    ),
                  );
                }),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
