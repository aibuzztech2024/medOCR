import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

/// A stylized card used to display key statistics such as
/// total purchases, reward points, earnings, etc.
class StatCardWidget extends StatelessWidget {
  final String title; // Label/title of the stat
  final String value; // Value to be shown
  final Color backgroundColor; // Background color of the card
  final Color textColor; // Color of the value text

  const StatCardWidget({
    super.key,
    required this.title,
    required this.value,
    this.backgroundColor = const Color(0xFFFFE4B5), // Default soft orange background
    this.textColor = const Color(0xFFF79E1B),       // Default amber text for values
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: backgroundColor,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Stat title (e.g., "Reward Points")
          AppText.body(
            title,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 8),
          // Stat value (e.g., "1400")
          AppText.heading(
            value,
            fontSize: 24,
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
