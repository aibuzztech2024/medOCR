import 'package:flutter/material.dart';
import 'package:avatar/models/advertiser/badge_level.dart';

class PointsViewModel {
  final int totalPoints;
  final String referralCode;
  final VoidCallback? onInvitePressed;
  final Map<String, int> pointsBreakdown;
  final List<BadgeLevel> badgeLevels;
  final bool showChart;
  final bool showInviteSection;
  final bool showHowToEarnSection;
  final bool showBadgeTimeline;

  PointsViewModel({
    this.totalPoints = 400,
    this.referralCode = 'rb4yn7g',
    this.onInvitePressed,
    Map<String, int>? customPointsBreakdown,
    List<BadgeLevel>? customBadgeLevels,
    this.showChart = true,
    this.showInviteSection = true,
    this.showHowToEarnSection = true,
    this.showBadgeTimeline = true,
  })  : pointsBreakdown = customPointsBreakdown ?? {
          'Map': 100,
          'Share': 100,
          'Referral': 100,
          'Purchase': 100,
          'Coupons': 100,
        },
        badgeLevels = customBadgeLevels ?? [
          BadgeLevel(
            title: 'SILVER BADGE',
            points: '999 points',
            benefits: [
              'Free access to a highly beneficial system.',
              'Heavy discount on all the purchases by Providers.',
              'Fast and easy to use platform for navigation, purchases and sharing.',
              'Recognition as an active community member',
            ],
            color: Colors.grey[600]!,
          ),
          BadgeLevel(
            title: 'GOLD BADGE',
            points: '1000 to 2499 points',
            benefits: [
              'All Silver level benefits.',
              'Priority placement in engagement-based features.',
              'Access to limited early feature previews.',
              'Special features and customized offers by Providers.',
            ],
            color: Colors.amber[600]!,
          ),
          BadgeLevel(
            title: 'DIAMOND BADGE',
            points: '+150 points per refill',
            benefits: [
              'All Gold-level benefits',
              'Special mentions in community spaces (where applicable)',
              'Invitations to participate in feedback sessions (when available)',
            ],
            color: Colors.blue[600]!,
          ),
        ];
}
