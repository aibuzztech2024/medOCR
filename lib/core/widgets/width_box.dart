import 'package:flutter/material.dart';

/// Custom box that adds specified [width] blank space

class WidthBox extends StatelessWidget {
  final double width;
  final double? height;

  /// It takes [width] as parameter and adds equivalent blank space
  /// Optional [height] parameter can be provided to set both dimensions
  const WidthBox(this.width, {this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }
}
