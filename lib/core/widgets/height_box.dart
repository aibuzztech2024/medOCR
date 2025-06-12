import 'package:flutter/material.dart';

/// Custom box that adds specified [height] blank space
class HeightBox extends StatelessWidget {
  final double height;
  final double? width;

  /// It takes [height] as parameter and adds equivalent blank space
  /// Optional [width] parameter can be provided to set both dimensions
  const HeightBox(this.height, {this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
