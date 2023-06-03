import 'package:flutter/material.dart';

// Grid dimensions
int rowLength = 10;
int colLength = 15;

enum Direction { left, right, down }

enum Tetromino { L, J, I, O, S, Z, T }

/*
  @
  @
  @ @

    @
    @
  @ @

  @
  @
  @
  @

  @ @
  @ @

    @ @
  @ @

  @ @
    @ @

  @
  @ @
  @
*/

const Map<Tetromino, Color> tetromioColors = {
  Tetromino.L: Colors.orangeAccent,
  Tetromino.J: Colors.lightBlueAccent,
  Tetromino.I: Colors.pinkAccent,
  Tetromino.O: Colors.yellowAccent,
  Tetromino.S: Colors.greenAccent,
  Tetromino.Z: Colors.redAccent,
  Tetromino.T: Colors.purpleAccent,
};
