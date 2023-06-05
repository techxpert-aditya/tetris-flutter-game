import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/game_components/piece.dart';
import 'package:tetris/game_components/pixel.dart';
import 'package:tetris/game_components/values.dart';
import 'package:tetris/constants.dart';
import 'package:tetris/screens/score.dart';
import 'package:audioplayers/audioplayers.dart';

/*

GAME BOARD

this is a 2x2 grid with null representing an empty  space.
A non emty space will have the color to represent the landed pieces.

*/

// cerate game board
List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  static const String id = "board_screen";
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

// enums for the swipe implimentation
enum SwipeDirection {
  none,
  left,
  right,
  up,
  down,
}

class _GameBoardState extends State<GameBoard> {
  // swipe direction
  SwipeDirection swipeDirection = SwipeDirection.none;

  //audio player
  final player = AudioPlayer();

  // current tetris piece
  Piece currentPiece = Piece(type: Tetromino.L);

  // score variable
  int currentScore = 0;

  //game over check variable
  bool gameOver = false;

  //init state
  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    player.play(AssetSource('tetris_gameStart.wav'));
    currentPiece.initializePiece();

    // frame refresh rate
    Duration frameRate = const Duration(milliseconds: 600);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        // clear lines
        clearLines();
        //check for the landing
        checkLanding();

        //check if game is over or not
        if (gameOver == true) {
          timer.cancel();
          resetGame();

          // play game over song
          player.play(AssetSource('tetris_gameOver.wav'));
          Navigator.pushReplacementNamed(
            context,
            Score.id,
            arguments: currentScore,
          );
          // showGameOverDialog();
        }
        // move the current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  // game over messege
  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: Text("Your score is: $currentScore"),
        actions: [
          TextButton(
            onPressed: () {
              // Reset the game
              resetGame();
              Navigator.pop(context);
            },
            child: const Text('Play Again!'),
          ),
        ],
      ),
    );
  }

  // reset teh game
  void resetGame() {
    // clear the game board
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(
        rowLength,
        (j) => null,
      ),
    );

    //new game
    gameOver = false;
    // currentScore = 0;

    // create new Piece
    createNewPiece();

    // start game again
    // startGame();
  }

  // check for collision in a future position
  // return true if there is a collision
  // return flase if there is no collision
  bool checkCollision(Direction direction) {
    // loop through eadch position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      // calculate the row and column of the current position
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = (currentPiece.position[i] % rowLength);

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // check if he piece is out of bounds (either too low or too far to the lfet or right) or hitting another piece
      if (row >= colLength ||
          col < 0 ||
          col >= rowLength ||
          (row >= 0 &&
              col >= 0 &&
              row < colLength &&
              col < rowLength &&
              gameBoard[row][col] != null)) {
        // if this is true then collision is detected
        return true;
      }
    }

    // if no collision are detected, return false
    return false;
  }

  void checkLanding() {
    // if going down is occupied, then we will start this function
    if (checkCollision(Direction.down)) {
      // now let's mark the position on the grid as occupied on the gameboard
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = (currentPiece.position[i] % rowLength);

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      // once the piece is landed, we need to create a new piece

      // first play the landing sound
      player.play(AssetSource('tetris_landing.wav'));

      //then create the new piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    //create random object to generate random piece
    Random rand = Random();

    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];

    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    //let's check the game is over or not
    if (isGameOver()) {
      gameOver = true;
    }
  }

  // clear lines
  void clearLines() {
    // step 1: loop through each row of the game board from bottom to top
    for (int row = colLength - 1; row >= 0; row--) {
      // step 2: Initialize a variable to track if the row is full
      bool rowIsFull = true;

      // step 3: check if the row is full or not
      for (int col = 0; col < rowLength; col++) {
        // if there's an empty column, set rowIsFull to false and break the loop
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      // step 4: if the row is full, we can clear it and shift the rows down
      if (rowIsFull) {
        // step 5: move all the rows above the cleard row down by one position
        for (int r = row; r > 0; r--) {
          // copy the abouve row to the current row
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        // step 6: set the top row to empty
        gameBoard[0] = List.generate(row, (index) => null);

        // also play the sound of line clear
        player.play(AssetSource('tetris_clearLine.wav'));
        // step 7: increase the score
        currentScore += 10;
      }
    }
  }

  // GAME OVER METHOD
  bool isGameOver() {
    // check if any columns in the top row are filled
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    //if the top row is empty, the game isn't over yet
    return false;
  }

  // Gesture recognition callbacks
  void onSwipeLeft() {
    if (swipeDirection != SwipeDirection.left) {
      swipeDirection = SwipeDirection.left;
      moveLeft();
    }
  }

  void onSwipeRight() {
    if (swipeDirection != SwipeDirection.right) {
      swipeDirection = SwipeDirection.right;
      moveRight();
    }
  }

  void onSwipeDown() {
    if (swipeDirection != SwipeDirection.down) {
      swipeDirection = SwipeDirection.down;
      moveDown();
    }
  }

  void onSwipeUp() {
    if (swipeDirection != SwipeDirection.up) {
      swipeDirection = SwipeDirection.up;
      rotatePiece();
    }
  }

  void resetSwipe() {
    swipeDirection = SwipeDirection.none;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          // Handle swipe gestures
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx > 0) {
              onSwipeRight();
            } else {
              onSwipeLeft();
            }
          },
          onVerticalDragUpdate: (details) {
            if (details.delta.dy > 0) {
              onSwipeDown();
            } else {
              onSwipeUp();
            }
          },
          onHorizontalDragEnd: (_) {
            resetSwipe();
          },
          onVerticalDragEnd: (_) {
            resetSwipe();
          },

          child: Column(
            children: [
              // GAME LOGO
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                          tag: 'logo',
                          child: Image.asset(
                            'images/tetris_outlined.png',
                            width: 50,
                          ),
                        ),
                        const Text(
                          ':',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          currentScore.toString(),
                          style: const TextStyle(
                            fontSize: 70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //GAME  GRID
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 10, right: 40, left: 40, bottom: 35),
                  decoration: const BoxDecoration(
                    color: Color(0xFF222831),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Material(
                    elevation: 10,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 50, left: 10, right: 10, bottom: 48),
                      child: Material(
                        elevation: 5,
                        color: Colors.transparent,
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                width: 1.0,
                                color: Color(0xFF393E46),
                              ),
                            ),
                          ),
                          child: GridView.builder(
                              itemCount: rowLength * colLength,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: rowLength),
                              itemBuilder: (context, index) {
                                // get row and col of each index
                                int row = (index / rowLength).floor();
                                int col = (index % rowLength);

                                //current piece
                                if (currentPiece.position.contains(index)) {
                                  return Pixel(
                                    colour: tetromioColors[currentPiece.type] ??
                                        Colors.white,
                                    childWidget: index,
                                  );
                                }

                                // landed piece
                                else if (gameBoard[row][col] != null) {
                                  final Tetromino? tetrominoType =
                                      gameBoard[row][col];
                                  return Pixel(
                                      colour: tetromioColors[tetrominoType] ??
                                          Colors.white,
                                      childWidget: index);
                                }

                                // blank pixel
                                else {
                                  return Pixel(
                                      colour: Colors.transparent,
                                      childWidget: index);
                                }
                              }),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // GAME CONTROLS
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 60, right: 60, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // left and right Buttons
                      Row(
                        children: [
                          //left
                          ElevatedButton(
                            style: kMovingButtonStyle.copyWith(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(0)),
                              ),
                            )),
                            onPressed: moveLeft,
                            child: const Icon(
                              Icons.arrow_back_ios,
                              // color: Colors.white,
                            ),
                          ),

                          // right
                          ElevatedButton(
                            style: kMovingButtonStyle.copyWith(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(20)),
                              ),
                            )),
                            onPressed: moveRight,
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              // color: Colors.white,
                            ),
                          ),

                          // down
                          IconButton(
                            onPressed: moveDown,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              // color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),

                      //rotate
                      IconButton(
                        onPressed: rotatePiece,
                        icon: const Icon(
                          Icons.rotate_right,
                          // color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void moveLeft() {
    player.play(AssetSource('tetris_move.wav'));
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    player.play(AssetSource('tetris_move.wav'));
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void moveDown() {
    player.play(AssetSource('tetris_move.wav'));
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.down)) {
      setState(() {
        currentPiece.movePiece(Direction.down);
      });
    }
  }

  void rotatePiece() {
    if (!checkCollision(Direction.left) && !checkCollision(Direction.right)) {
      currentPiece.rotatePiece();
    }
  }
}
