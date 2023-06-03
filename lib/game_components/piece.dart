import 'package:flutter/material.dart';
import 'package:tetris/screens/board.dart';

import 'values.dart';

class Piece {
  // type of tetris piece
  late Tetromino type;

  Piece({required this.type});

  // the ppiece is just a list  of integers
  List<int> position = [];

  //color of tetris piece
  Color get color {
    return tetromioColors[type] ?? Colors.white;
  }

  // generate  the integers
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];
        break;
      case Tetromino.J:
        position = [-25, -15, -6, -5];
        break;
      case Tetromino.I:
        position = [-36, -26, -16, -6];
        break;
      case Tetromino.O:
        position = [-16, -15, -6, -5];
        break;
      case Tetromino.S:
        position = [-15, -16, -6, -7];
        break;
      case Tetromino.Z:
        position = [-17, -16, -6, -5];
        break;
      case Tetromino.T:
        position = [-26, -16, -15, -6];
        break;
      default:
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  // rotate piece
  int rotationState = 1;

  void rotatePiece() {
    //new position
    List<int> newPosition = [];

    //roate the picec based on it's type
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            /*

              @
              @
              @
              @ @

              */

            // get new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];

            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = 0; // reset rotation state to 0
            }
            break;
        }
        break;
      case Tetromino.J:
        switch (rotationState) {
          case 0:

            // get new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1,
            ];

            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = 0; // reset the rotation state  to 0
            }
            break;
        }
        break;
      case Tetromino.I:
        switch (rotationState) {
          case 0:

            // get new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];

            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = 0; // reset the rotation state  to 0
            }
            break;
        }
        break;
      case Tetromino.O:
        // the O tetromino does not need  to be rotated
        break;

      case Tetromino.S:
        switch (rotationState) {
          case 0:

            // get new position
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];

            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = 0; // reset the rotation state  to 0
            }
            break;
        }
        break;

      case Tetromino.Z:
        switch (rotationState) {
          case 0:

            // get new position
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];

            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = 0; // reset the rotation state  to 0
            }
            break;
        }
        break;

      case Tetromino.T:
        switch (rotationState) {
          case 0:

            // get new position
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];

            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            // check before assigning that the new position is valid or not
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation  state
              rotationState = 0; // reset the rotation state  to 0
            }
            break;
        }
        break;
    }
  }

  // check if valid postion
  bool positionIsValid(int position) {
    // get the row and col of position
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    // if the position is taken, return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }

    // else return true
    else {
      return true;
    }
  }

  // check if piece is valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      if (!positionIsValid(pos)) {
        return false;
      }

      //get the  col of position
      int col = pos % rowLength;

      // check if the first or last column is occupied by the same piece
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }

    // if there is a piece in the first and last col, it is going through the wall
    return !(firstColOccupied && lastColOccupied);
  }
}
