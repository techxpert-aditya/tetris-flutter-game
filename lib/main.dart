import 'package:flutter/material.dart';
import 'screens/board.dart';
import 'screens/home.dart';
import 'screens/score.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        GameBoard.id: (context) => const GameBoard(),
        Score.id: (context) => const Score()
      },
    );
  }
}
