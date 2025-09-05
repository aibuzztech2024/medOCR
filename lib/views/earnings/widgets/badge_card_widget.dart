import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/models/earnings/badge_model.dart';
import 'package:flutter/material.dart';

/// A card widget that displays a list of badges explaining
/// how users can earn points (e.g., completing tasks, purchases).
class BadgeCardWidget extends StatelessWidget {
  final List<BadgeModel> badges;

  const BadgeCardWidget({super.key, required this.badges});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: LightThemeColors.thirdpharmacyColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(4, 4),
            blurRadius: 10,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          AppText.heading(
            'How to earn points',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),

          const SizedBox(height: 16),

          // Generate badge rows from the list
          ...badges.map((badge) => _buildBadgeItem(badge)).toList(),
        ],
      ),
    );
  }

  /// Builds individual badge info rows
  Widget _buildBadgeItem(BadgeModel badge) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge Title and Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.heading(
                  badge.name,
                  fontWeight: FontWeight.w600,
                  color: LightThemeColors.pharmacyColor,
                ),
                const SizedBox(height: 4),
                AppText.body(badge.description, fontWeight: FontWeight.w400),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Points range (e.g., "10-50")
          AppText.heading(
            badge.pointsRange,
            fontWeight: FontWeight.w400,
            color: LightThemeColors.pharmacyColor,
          ),
        ],
      ),
    );
  }
}
