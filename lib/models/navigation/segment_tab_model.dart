import 'package:flutter/material.dart';

class SegmentTabModel {
  final String label;
  final IconData? iconData;
  final String? iconSvgPath;
  final Color activeColor;
  final Widget child;

  SegmentTabModel({
    required this.label,
    this.iconData,
    this.iconSvgPath,
    required this.activeColor,
    required this.child,
  }) : assert(
         (iconData != null && iconSvgPath == null) ||
             (iconData == null && iconSvgPath != null),
         'Either iconData or iconSvgPath must be provided, but not both.',
       );
}
