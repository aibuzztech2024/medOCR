import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/models/advertiser/claimed_reward_model.dart';
import 'package:flutter/material.dart';

// this is the reward claimed widget
class RewardsClaimed extends StatelessWidget {
  final ClaimedReward reward;
  final bool isPointsHistory;

  const RewardsClaimed({
    super.key,
    required this.reward,
    this.isPointsHistory = false,
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
              // Centered Image Container
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 60,
                      height: isPointsHistory ? 60 : 80,
                      color: LightThemeColors.advertisorColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(reward.imageUrl, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              // Text content
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    AppText.caption(
                      'Claimed on: ${reward.claimedOn}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (!isPointsHistory)
                      AppText.caption(
                        'Expired on: ${reward.expiredOn}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Points
              isPointsHistory
                  ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: AppText.caption(reward.points.toStringAsFixed(2)),
                    ),
                  )
                  : Align(
                    alignment: Alignment.topRight,
                    child: AppText.caption(reward.points.toStringAsFixed(2)),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
