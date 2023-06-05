import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class About extends StatefulWidget {
  static const String id = "about_screen";
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'About',
          style: TextStyle(color: Color(0xFF222831)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF222831),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo goes here
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: const Color(0xFF222831),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'images/tetris_about.gif',
                        scale: 4.0,
                      ),
                    ),
                  ),
                ),

                //the about section
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 20,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: Container(
                          height: 500,
                          width: 300,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0xFF222831),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'Hello there 👋\n\nTetris, the timeless puzzle game⏳🎮, combines strategy and agility as players 🎵🧠 strategically place falling tetromino shapes 🕹️🧩 to clear lines and achieve victory. 🎮⚡️ With its iconic design and addictive gameplay, Tetris captivates gamers worldwide, symbolizing creativity and joy. 🌍😄 Embrace the challenge, embark on the addictive journey! 🚀🔥',
                                  textStyle: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                  speed: const Duration(milliseconds: 25),
                                ),
                              ],
                              totalRepeatCount: 1,
                              pause: const Duration(milliseconds: 0),
                              displayFullTextOnTap: true,
                              stopPauseOnTap: true,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'TETRIS ♥ FLUTTER',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ),

                //footer
                const Text(
                  'C R E A T E D . B Y . A D I',
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
