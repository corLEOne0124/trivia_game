import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_game/features/home/cubit/home_cubit.dart';
import 'package:trivia_game/features/splash.dart';
import 'package:trivia_game/shared/supplements/constants/theme_globals.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => cubit
            ..getSessionToken()
            ..fetchCategories(),
        ),
      ],
      child: MaterialApp(
        title: 'Trivia game',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: whiteColor,
            appBarTheme: const AppBarTheme(backgroundColor: whiteColor)),
        home: const SplashScreen(),
      ),
    );
  }
}
