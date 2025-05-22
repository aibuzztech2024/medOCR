import 'package:flutter/material.dart';

/// Custom box that adds specified [width] blank space

class WidthBox extends StatelessWidget {
  final double width;

  /// It takes [width] as parameter and adds equivalent blank space
  const WidthBox(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
