import 'package:flutter/material.dart';

/// This class contains all color constants used in the LightThemeData.
class LightThemeColors {
  // Primary action color (buttons, icons, focus borders)
  static const Color primary = Color(0xFF1A4EAA);

  // Backgrounds
  static const Color scaffoldBackground = Colors.white;
  static const Color inputFill = Color(0xFFF8F9FB);
  static const Color cardBackground = Colors.white;

  // Borders
  static const Color inputBorder = Color(0xFFDCE0E5);
  static const Color dividerColor = Color(0xFFE0E0E0);

  // Hint
  static const Color hintColor = Color(0x991E4D92);

  // Text
  static const Color titleText = primary;
  static const Color subtitleText = Colors.black54;
  static const Color bodyText = Colors.black87;
  static const Color hintText = Colors.black45;

  // Button text
  static const Color buttonText = Colors.white;

  // Icon
  static const Color icon = primary;
  static const Color orangeicon = Colors.orange;

  // Prescription View specific colors
  static const Color prescriptionBorder = Color(
    0xFFE0E0E0,
  ); // Light grey for borders
  static const Color prescriptionBackground = Colors.white; // White background

  // Shadow
  static const Color shadowColor = Color(0x1F000000);
}
