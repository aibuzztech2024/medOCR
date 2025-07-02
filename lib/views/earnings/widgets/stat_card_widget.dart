import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

/// A stylized card used to display key statistics such as
/// total purchases, reward points, earnings, etc.
class StatCardWidget extends StatelessWidget {
  final String title; // Label/title of the stat
  final String value; // Value to be shown
  final Color textColor; // Color of the value text

  const StatCardWidget({
    super.key,
    required this.title,
    required this.value,
    // Default soft orange background
    this.textColor =
        LightThemeColors.pharmacyColor, // Default amber text for values
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 100,
      ), // ensures minimum size, but expands if needed
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: LightThemeColors.pharmacyColor.withOpacity(
          0.35,
        ), // Soft orange background
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(4, 4), // x and y shadow offset
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // prevents extra height
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Stat title (e.g., "Reward Points")
          Flexible(
            child: AppText.body(
              title,
              fontWeight: FontWeight.w400,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 6),
          // Stat value (e.g., "1400")
          Flexible(
            child: AppText.heading(
              value,
              fontSize: 24,
              color: textColor,
              fontWeight: FontWeight.w700,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
