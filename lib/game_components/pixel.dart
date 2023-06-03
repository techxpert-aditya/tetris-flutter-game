import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  const Pixel({super.key, required this.colour, required this.childWidget});
  final Color colour;
  final int childWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.all(1),
    );
  }
}
