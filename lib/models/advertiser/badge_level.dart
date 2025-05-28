import 'package:flutter/material.dart';

class BadgeLevel {
  final String title;
  final String points;
  final List<String> benefits;
  final Color color;

  const BadgeLevel({
    required this.title,
    required this.points,
    required this.benefits,
    required this.color,
  });
}