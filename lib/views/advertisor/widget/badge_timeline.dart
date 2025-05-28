import 'package:avatar/models/advertiser/badge_level.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class BadgeTimeline extends StatelessWidget {
  final List<BadgeLevel> badgeLevels;

  const BadgeTimeline({
    super.key,
    required this.badgeLevels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: badgeLevels.asMap().entries.map((entry) {
          final index = entry.key;
          final badge = entry.value;
          return _buildBadgeTile(
            title: badge.title,
            points: badge.points,
            benefits: badge.benefits,
            badgeColor: badge.color,
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
          child: const Icon(Icons.emoji_events, color: Colors.white, size: 20),
        ),
      ),
      endChild: Container(
        margin: const EdgeInsets.only(left: 16, bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            ...benefits
                .map(
                  (benefit) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '- $benefit',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                  ),
                )
                .toList(),
            const SizedBox(height: 12),
            Text(
              points,
              style: TextStyle(
                fontSize: 14,
                color: Colors.red[400],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}