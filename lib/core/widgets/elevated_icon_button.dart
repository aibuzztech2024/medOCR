import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class elevated_IconButton extends StatelessWidget {
  final dynamic icon; // IconData or String (SVG path)
  final Color? backgroundColor;
  final Color? iconColor;
  final double? elevation;
  final double? size;
  final VoidCallback? onPressed;

  const elevated_IconButton({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    this.elevation,
    this.size,
    this.onPressed,
  });

  bool get isSvg => icon is String;

  @override
  Widget build(BuildContext context) {
    final double iconSize = (size ?? 40) * 0.65;
    final double svgSize = (size ?? 40) * 0.5;

    return Material(
      color: backgroundColor ?? Colors.white,
      elevation: elevation ?? 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: SizedBox(
          width: size ?? 40,
          height: size ?? 40,
          child: Center(
            child: isSvg
                ? SvgPicture.asset(
              icon,
              color: iconColor ?? Colors.black,
              width: svgSize,
              height: svgSize,
            )
                : Icon(
              icon,
              color: iconColor ?? Colors.black,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}

