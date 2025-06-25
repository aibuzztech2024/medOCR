import 'package:flutter/material.dart';
import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/models/points/claimed_reward_model.dart';

/// Widget to show each claimed reward in a card format
class RewardsClaimed extends StatelessWidget {
  final ClaimedReward reward;
  final bool isPointsHistory;
  final Color color;

  const RewardsClaimed({
    super.key,
    required this.reward,
    this.isPointsHistory = false, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      color: Colors.white,
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 60,
                      height: isPointsHistory ? 60 : 80,
                      color: color,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(reward.imageUrl, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText.heading(
                      reward.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    AppText.body(
                      reward.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    FittedBox(
                      child: AppText.caption('Claimed on: ${reward.claimedOn}'),
                    ),
                    if (!isPointsHistory)
                      FittedBox(
                        child: AppText.caption(
                          'Expired on: ${reward.expiredOn}',
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Points
              Align(
                alignment:
                    isPointsHistory
                        ? Alignment.topRight
                        : Alignment.centerRight,
                child: AppText.caption(reward.points.toStringAsFixed(2)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
