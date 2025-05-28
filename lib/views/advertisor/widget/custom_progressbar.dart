import 'package:flutter/material.dart';

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
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$currentPoints/$totalPoints',
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          color: Colors.redAccent,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
