import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/models/points/badge_level.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

// this is the timeline package widget used in points screen
class BadgeTimeline extends StatelessWidget {
  final List<BadgeLevel> badgeLevels;

  const BadgeTimeline({super.key, required this.badgeLevels});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children:
            badgeLevels.asMap().entries.map((entry) {
              final index = entry.key;
              final badge = entry.value;
              return _buildBadgeTile(
                title: badge.title,
                points: badge.points,
                benefits: badge.benefits,
                badgeColor: badge.color,
                image: badge.image, // image

                isFirst: index == 0,
                isLast: index == badgeLevels.length - 1,
              );
            }).toList(),
      ),
    );
  }

  Widget _buildBadgeTile({
    required String title,
    required String points,
    required String image,
    required List<String> benefits,
    required Color badgeColor,
    required bool isFirst,
    required bool isLast,
  }) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(color: Colors.grey[300]!, thickness: 2),
      indicatorStyle: IndicatorStyle(
        width: 40,
        height: 40,
        indicator: Container(
          decoration: BoxDecoration(color: badgeColor, shape: BoxShape.circle),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(image, fit: BoxFit.contain), //  image here
          ),
        ),
      ),
      endChild: Container(
        margin: const EdgeInsets.only(left: 16, bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.heading(title),

            const SizedBox(height: 8),
            ...benefits.map(
              (benefit) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: AppText.body('- $benefit'),
              ),
            ),
            const SizedBox(height: 12),
            AppText.body(
              points,
              color: LightThemeColors.advertisorColor,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
