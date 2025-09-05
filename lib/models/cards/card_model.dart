import 'package:flutter/material.dart';

//Todo: card model
// TODO: Add validation for required fields if needed

class CardModel {
  final String title;
  final String? subtitle;
  final Color? subtitleColor;
  final String imagePath;
  final String buttonLabel;
  final List<Color> gradientColors;
  final Widget icon;
  final Color titleColor;

  CardModel({
    this.subtitle,
    this.subtitleColor,
    required this.title,
    required this.imagePath,
    required this.buttonLabel,
    required this.gradientColors,
    required this.icon,
    required this.titleColor,
  });
}
