import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/models/endcustomer/rewards_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// RewardCard displays a single featured reward with image, title, and coupon code.
/// Can be tapped to perform an action (e.g., view details, copy code).
class RewardCard extends StatelessWidget {
  final RewardModel reward;
  final VoidCallback onTap;

  const RewardCard({super.key, required this.reward, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap, // ⏺️ Trigger action when card is tapped (e.g., open detail screen)
      child: Container(
        width: 274,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼️ Image Section (top)
            Container(
              height: 78,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: AssetImage(
                    reward.image,
                  ), // TODO: Replace with NetworkImage for dynamic assets
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 📄 Content Section (bottom)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left: Text info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.caption(
                          'COUPON',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFF79E1B),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 101,
                          child: AppText.caption(
                            reward
                                .title, // 🏷️ Title of reward (e.g., "20% off Electronics")
                            fontWeight: FontWeight.w700,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    // Right: Coupon Code Button
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF79E1B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText.body(
                            reward.couponCode, // 🎁 The coupon code text
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.copy, color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
