import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trivia_game/features/home/view.dart';
import 'package:trivia_game/shared/supplements/constants/theme_globals.dart';

class StyledAlertDialog extends StatelessWidget {
  final String message;
  const StyledAlertDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: MediaQuery.of(context).size.width < 1000
              ? null
              : const EdgeInsets.symmetric(horizontal: 300),
          constraints: const BoxConstraints(minWidth: 200),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xfff75554),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/vector/clock.svg'),
              const SizedBox(height: 32),
              Text(
                message,
                style: titleLarge.copyWith(
                  color: whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 64),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false);
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: whiteColor,
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
                  child: Center(
                    child: Text(
                      'Go to Home',
                      style: titleMedium.copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
