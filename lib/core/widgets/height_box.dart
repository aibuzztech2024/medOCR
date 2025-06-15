import 'package:flutter/material.dart';

/// Custom box that adds specified [height] blank space
class HeightBox extends StatelessWidget {
  final double height;


  /// It takes [height] as parameter and adds equivalent blank space

  const HeightBox(this.height, { super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
