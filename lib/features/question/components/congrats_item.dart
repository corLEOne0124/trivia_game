import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trivia_game/shared/supplements/constants/theme_globals.dart';

class CongratsScreen extends StatefulWidget {
  final int userResult;
  const CongratsScreen({super.key, required this.userResult});

  @override
  State<CongratsScreen> createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
  late ConfettiController _controllerCenter;
  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 30));
    _controllerCenter.play();
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff487eef),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.close,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      backgroundColor: const Color(0xff487eef),
      body: SafeArea(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality
                  .explosive, // don't specify a direction, blast randomly
              shouldLoop:
                  true, // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // manually specify the colors to be used
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SvgPicture.asset(
                  'assets/vector/congrats.svg',
                  fit: BoxFit.scaleDown,
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
              ),
              Text(
                getCongratsMessage(),
                style: headlineMedium.copyWith(
                    color: whiteColor, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Your result: ${widget.userResult}',
                style: titleLarge.copyWith(
                    color: whiteColor, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      )),
    );
  }

  String getCongratsMessage() {
    if (widget.userResult >= 0 && widget.userResult < 4) {
      return "Good effort! Keep practicing!";
    } else if (widget.userResult >= 4 && widget.userResult < 8) {
      return "Well done! You're improving!";
    } else if (widget.userResult >= 8 && widget.userResult <= 10) {
      return "Congratulations! You nailed it!";
    } else {
      return "Congratulations!";
    }
  }
}
