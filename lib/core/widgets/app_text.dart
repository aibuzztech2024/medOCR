import 'package:flutter/material.dart';

/// A reusable and simplified text widget that allows easy customization.
/// [AppText] reduces boilerplate by letting you set common [TextStyle] values
/// directly, and includes named constructors like `.heading(), `.body()`, and
/// `.caption()` for consistent app-wide typography usage.
class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextScaler? textScaleFactor;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textScaleFactor,
  });

  /// Heading style (based on titleLarge)
  factory AppText.heading(
    String text, {
    Key? key,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      key: key,
      style: TextStyle(
        color: color,
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// Body text style (based on bodyMedium)
  factory AppText.body(
    String text, {
    Key? key,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      key: key,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// Caption or helper style (based on labelSmall or caption)
  factory AppText.caption(
    String text, {
    Key? key,
    Color? color,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      key: key,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Fallback logic for inherited styling from theme
    final effectiveStyle =
        style?.copyWith(
          fontSize: style?.fontSize ?? textTheme.bodyMedium?.fontSize,
          color: style?.color ?? textTheme.bodyMedium?.color,
        ) ??
        textTheme.bodyMedium;

    return Material(
      type: MaterialType.transparency,
      child: Text(
        text,
        style: effectiveStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
        textScaler: textScaleFactor ?? MediaQuery.of(context).textScaler,
      ),
    );
  }
}
