import 'package:avatar/models/advertiser/reward_model.dart';
import 'package:avatar/views/advertisor/widget/couponcode_box.dart';
import 'package:avatar/views/advertisor/widget/custom_progressbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RewardCardWidget extends StatelessWidget {
  final Reward reward;

  const RewardCardWidget({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    final progress = reward.currentPoints / reward.totalPoints;
    final hasImage = reward.imageUrl != null && reward.imageUrl!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 220,
        width: double.infinity,
        child: Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.pink.shade50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasImage) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        reward.imageUrl!,
                        width: 80,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reward.headerText,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            reward.subheadingText,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          PointsProgressBar(
                            title: reward.lowerHeadingText,
                            currentPoints: reward.currentPoints,
                            totalPoints: reward.totalPoints,
                            progress: progress,
                          ),

                          const SizedBox(height: 8),
                          CouponCodeBox(
                            couponCode: reward.couponCode,
                            onCopy: () {
                              Clipboard.setData(
                                ClipboardData(text: reward.couponCode),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Coupon code copied!'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 30,
              right: 0,
              child: Container(
                width: 20,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
