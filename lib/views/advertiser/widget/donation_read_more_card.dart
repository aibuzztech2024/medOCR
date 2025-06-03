import 'package:avatar/views/advertiser/donate/donation_detailed_read_more_controller.dart';
import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DonationCardModel {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String distance;
  final String category;
  final String description;
  final String websiteUrl;

  DonationCardModel({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.distance,
    required this.category,
    required this.description,
    required this.websiteUrl,
  });
}

// Reusable donation card widget component with dynamic height
class DonationReadMoreCard extends StatelessWidget {
  final DonationCardModel data;
  final double? customWidth;

  const DonationReadMoreCard({Key? key, required this.data, this.customWidth})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate dynamic width based on design ratios
    // Original design: 366px width in 402px screen
    final cardWidth = customWidth ?? (screenWidth * 0.911); // 366/402 ratio

    // Use the existing DonationCardReadMoreController instead of creating a new one
    final controller = Get.find<DonationCardReadMoreController>();

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with padding
          Padding(
            padding: EdgeInsets.all(cardWidth * 0.065),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: NetworkImage(data.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Content section with padding
          Padding(
            padding: EdgeInsets.all(cardWidth * 0.065),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title section
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 6),

                // Subtitle section
                Text(
                  data.subtitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 12),

                // Distance and category row
                Row(
                  children: [
                    Text(
                      data.distance,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    // Bullet point separator
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: cardWidth * 0.02,
                      ),
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                    ),

                    Text(
                      data.category,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Description section
                Text(
                  data.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.justify,
                ),

                const SizedBox(height: 20),

                // Action buttons row
                Obx(
                  () => Row(
                    children: [
                      // UPI Icon
                      SvgPicture.asset('assets/icons/upi.svg'),

                      SizedBox(width: screenWidth * 0.02),

                      // Visit Website button
                      Expanded(
                        flex: 1,
                        child: AppButton(
                          type: ButtonType.outlined,
                          child: AppText.body(
                            controller.isLoading.value
                                ? 'Loading...'
                                : 'Visit Website',
                            color: const Color(0xFFFF6B6B),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          onPressed:
                              () => controller.visitWebsite(data.websiteUrl),
                          width: null,
                          height: 30,
                          color: const Color(0xFFFF6B6B),
                          textColor: const Color(0xFFFF6B6B),
                          borderRadius: 10,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02,
                          ),
                        ),
                      ),

                      SizedBox(width: screenWidth * 0.02),

                      // Pay button
                      Expanded(
                        flex: 1,
                        child: AppButton(
                          type: ButtonType.filled,
                          text:
                              controller.isProcessingPayment.value
                                  ? 'Processing...'
                                  : 'Pay',
                          onPressed: () => controller.handlePayment(),
                          width: null,
                          height: 30,
                          color: const Color(0xFFFF6B6B),
                          textColor: Colors.white,
                          borderRadius: 10,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
