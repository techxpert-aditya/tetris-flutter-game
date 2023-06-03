import 'package:flutter/material.dart';
import 'package:tetris/constants.dart';
import 'package:tetris/screens/board.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "home_screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset(
                'images/tetris.png',
                scale: 4.0,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'TETRIS',
              style: kHomeScreenDisplayTextStyle,
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              style: kHomeScreenElevatedButtonStyle,
              onPressed: () {
                Navigator.pushNamed(context, GameBoard.id);
              },
              child: const Text(
                'PLAY',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: kHomeScreenElevatedButtonStyle,
              onPressed: () {},
              child: const Text(
                'LEADERBOARD',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
