import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';

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
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // current tetris piece
  Piece currentPiece = Piece(type: Tetromino.T);

  @override
  void initState() {
    super.initState();
    startGame();

    // frame refresh rate
    Duration frameRate = const Duration(milliseconds: 200);
    // gameLoop(frameRate);
  }

  void startGame() {
    currentPiece.initializePiece();
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        //check for the landing
        checkLanding();
        // move the current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C134F),
      body: GridView.builder(
          itemCount: rowLength * colLength,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rowLength),
          itemBuilder: (context, index) {
            // get row and col of each index
            int row = (index / rowLength).floor();
            int col = (index % rowLength);

            //current piece
            if (currentPiece.position.contains(index)) {
              return Pixel(
                colour: Colors.yellow,
                childWidget: index,
              );
            } else if (gameBoard[row][col] != null) {
              return Pixel(colour: Colors.pink, childWidget: index);
            } else {
              return Pixel(colour: const Color(0xFF1D267D), childWidget: index);
            }
          }),
    );
  }
}

// Pixel(
//           colour: currentPiece.position.contains(index)
//               ? Colors.yellow
//               : const Color(0xFF1D267D),
//           childWidget: index,
//         ),
