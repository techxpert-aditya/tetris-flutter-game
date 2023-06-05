import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetris/screens/home.dart';

class Splash extends StatefulWidget {
  static const String id = 'splash_screen';
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2200),
        () => Navigator.pushReplacementNamed(context, HomeScreen.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'images/Tetris_splash.gif',
            scale: 4.0,
          ),
        ),
      ),
    );
  }
}
