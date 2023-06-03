import 'package:flutter/material.dart';
import 'package:tetris/home.dart';
import 'board.dart';

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
      },
    );
  }
}
