import 'package:flutter/material.dart';
import 'package:tetris/constants.dart';
import 'package:tetris/screens/board.dart';

class Score extends StatelessWidget {
  static const String id = "score_screen";
  const Score({super.key});

  @override
  Widget build(BuildContext context) {
    final int userScore = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      backgroundColor: const Color(0xFF222831),
      body: SafeArea(
          child: Center(
              child: Column(
        children: [
          Expanded(
            flex: 9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'images/tetris_block.png',
                    scale: 1.2,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'GAME OVER',
                  style: kScoreScreenDisplayTextStyle,
                ),
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'score',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  userScore.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'BACK TO HOME',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: kScoreScreenPlayButtonStyle,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, GameBoard.id);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'PLAY AGAIN',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ))),
    );
  }
}
