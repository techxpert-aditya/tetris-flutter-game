import 'package:flutter/material.dart';
import 'package:tetris/constants.dart';
import 'package:tetris/screens/board.dart';
import 'package:audioplayers/audioplayers.dart';
import 'about.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final player = AudioPlayer();

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    player.play(AssetSource('tetris_soundtrack.mp3'));
  }

  bool isMusicOn = true;

  void toggleMusic() {
    setState(() {
      isMusicOn = !isMusicOn;
      isMusicOn ? player.setVolume(0.5) : player.setVolume(0.0);
    });
  }

  @override
  void dispose() {
    super.dispose();
    player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          //the music button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: toggleMusic,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Set the border radius here
                    ),
                  ),
                ),
                child: isMusicOn
                    ? const Icon(
                        Icons.music_note_sharp,
                        color: Colors.black87,
                      )
                    : const Icon(
                        Icons.music_off,
                        color: Colors.black87,
                      ),
              ),
            ],
          ),
          //ui of the whole app
          Center(
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
                  onPressed: () {
                    Navigator.pushNamed(context, About.id);
                  },
                  child: const Text(
                    'ABOUT',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
