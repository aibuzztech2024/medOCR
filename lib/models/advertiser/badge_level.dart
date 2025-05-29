import 'package:flutter/material.dart';

//t his is badge level model for badge level widget
class BadgeLevel {
  final String title;
  final String points;
  final String image;
  final List<String> benefits;
  final Color color;

  const BadgeLevel({
    required this.title,
    required this.image,
    required this.points,
    required this.benefits,
    required this.color,
  });
}