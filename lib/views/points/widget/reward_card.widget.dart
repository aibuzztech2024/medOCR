import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/models/points/reward_model.dart';
import 'package:avatar/views/points/widget/couponcode_box.dart';
import 'package:avatar/views/points/widget/custom_progressbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// this is the reard card widget
class RewardCardWidget extends StatelessWidget {
  final Reward reward;
  final bool isPopularcoupon;
  const RewardCardWidget({
    super.key,
    this.isPopularcoupon = false,
    required this.reward,
  });

  @override
  Widget build(BuildContext context) {
    final progress = reward.currentPoints / reward.totalPoints;
    final hasImage = reward.imageUrl != null && reward.imageUrl!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
      child: SizedBox(
        height: 220,
        width: double.infinity,
        child: Stack(
          children: [
            //card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color:
                  isPopularcoupon
                      ? LightThemeColors.inputFill
                      : LightThemeColors.advertisorColor15,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasImage) ...[
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Image.asset(
                        reward.imageUrl!,
                        width: 100,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 2),
                  ],
                  // for text content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppText.body(
                            reward.headerText,
                            fontWeight: FontWeight.bold,
                          ),

                          const SizedBox(height: 4),
                          AppText.caption(reward.subheadingText),

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
                              Get.snackbar('Success', 'Coupon code copied!');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //side circle like design
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
