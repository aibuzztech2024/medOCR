import 'package:flutter/material.dart';

class NavItemModel {
  final String icon;
  final String title;
  final Widget screen;
  final bool isCustomIcon;
  final Widget? customIcon;
  final Widget? child;

  NavItemModel({
    required this.icon,
    required this.title,
    required this.screen,
    this.isCustomIcon = false,
    this.customIcon,
    this.child,
  }) : assert(
         !isCustomIcon || customIcon != null,
         'Custom icon must be provided when isCustomIcon is true',
       );
}
