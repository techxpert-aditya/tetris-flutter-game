import 'package:flutter/material.dart';

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
            Image.asset(
              'images/tetris.png',
              scale: 4.0,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'TETRIS',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: 'tetris_fonts',
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Start game',
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Leader board',
              ),
            ),
          ],
        ),
      )),
    );
  }
}
