import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:flutter/material.dart';

/// Defines the [ThemeData] used for the light theme of the application.
///
/// This theme includes color, typography, input field, button, and icon styling
/// as defined in the [LightThemeColors] class.
final ThemeData lightThemeData = ThemeData(
  /// Sets the overall brightness to light
  brightness: Brightness.light,

  /// Uses Material 3 color system with a seed color
  colorScheme: ColorScheme.fromSeed(
    seedColor: LightThemeColors.primary,
    brightness: Brightness.light,
  ),

  /// Sets the hint color
  hintColor: LightThemeColors.hintColor,

  /// Primary color used throughout the app (e.g. buttons, active elements)
  primaryColor: LightThemeColors.primary,

  /// Default background color for all scaffold widgets
  scaffoldBackgroundColor: LightThemeColors.scaffoldBackground,

  // ✅ Set cursor color globally using TextSelectionThemeData
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: LightThemeColors.primary,
    selectionColor: LightThemeColors.primary.withOpacity(0.4),
    selectionHandleColor: LightThemeColors.primary,
  ),

  /// Text styles used across the app
  textTheme: const TextTheme(
    /// Large title style (e.g. for headings)
    titleLarge: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: LightThemeColors.titleText,
    ),

    /// Medium title style (e.g. for subtitles or section titles)
    titleMedium: TextStyle(
      fontSize: 16.0,
      color: LightThemeColors.subtitleText,
    ),

    /// Regular body text style
    bodyMedium: TextStyle(fontSize: 14.0, color: LightThemeColors.bodyText),
  ),

  ///Style configuration for all input fields (TextField, TextFormField)
  inputDecorationTheme: InputDecorationTheme(
    /// Padding inside input fields
    contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20),

    /// enabled border style used unless overridden
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: LightThemeColors.primary, width: 1.5),
    ),

    /// focused border style used unless overridden
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: LightThemeColors.primary, width: 1.5),
    ),

    /// Default border style used unless overridden
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: LightThemeColors.primary, width: 1.5),
    ),

    /// Hint text style (e.g. placeholder text)
    hintStyle: const TextStyle(color: LightThemeColors.hintColor),
  ),

  /// Styling for ElevatedButtons used in the app
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightThemeColors.primary,
      foregroundColor: LightThemeColors.buttonText,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ),

  /// Default style for icons used across the app
  iconTheme: IconThemeData(color: Colors.black87, size: 24),
);
