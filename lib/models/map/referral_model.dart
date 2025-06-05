import 'package:flutter/material.dart';

//Todo:referal card model
class ReferCardModel {
  final String title;
  final String imagePath;
  final String buttonLabel;
  final List<Color> gradientColors;
  final IconData icon;
  final Color titleColor;

  ReferCardModel({
    required this.title,
    required this.imagePath,
    required this.buttonLabel,
    required this.gradientColors,
    required this.icon,
    required this.titleColor,
  });
}
