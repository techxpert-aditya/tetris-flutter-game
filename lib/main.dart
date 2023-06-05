import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/board.dart';
import 'screens/home.dart';
import 'screens/score.dart';
import 'screens/about.dart';
import 'screens/splash.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.id,
      routes: {
        Splash.id: (context) => const Splash(),
        HomeScreen.id: (context) => const HomeScreen(),
        About.id: (context) => const About(),
        GameBoard.id: (context) => const GameBoard(),
        Score.id: (context) => const Score(),
      },
    );
  }
}
