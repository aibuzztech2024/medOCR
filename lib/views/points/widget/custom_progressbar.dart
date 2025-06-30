import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

// this is the progress bar which calcated the progress when used with points like 20/100
class PointsProgressBar extends StatelessWidget {
  final String title;
  final int currentPoints;
  final int totalPoints;
  final double progress;

  const PointsProgressBar({
    super.key,
    required this.title,
    required this.currentPoints,
    required this.totalPoints,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.body(title, fontWeight: FontWeight.w400),
            AppText.caption(
              '$currentPoints/$totalPoints',
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(height: 8),

        // indicator
        LinearProgressIndicator(
          value: progress,
          color: LightThemeColors.advertisorColor,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
