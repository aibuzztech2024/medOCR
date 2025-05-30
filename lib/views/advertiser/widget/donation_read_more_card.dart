import 'package:avatar/views/advertiser/donate/donation_detailed_read_more_controller.dart';
import 'package:avatar/views/advertiser/widget/custom_button.dart';
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

// Reusable donation card widget component
class DonationReadMoreCard extends StatelessWidget {
  final DonationCardModel data;
  final double? customHeight;
  final double? customWidth;

  const DonationReadMoreCard({
    Key? key,
    required this.data,
    this.customHeight,
    this.customWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate dynamic dimensions based on design ratios
    // Original design: 757px height in 874px screen, 366px width in 402px screen
    final cardHeight = customHeight ?? (screenHeight * 0.866); // 757/874 ratio
    final cardWidth = customWidth ?? (screenWidth * 0.911); // 366/402 ratio

    // Use the existing DonationCardReadMoreController instead of creating a new one
    final controller = Get.find<DonationCardReadMoreController>();

    return Container(
      height: cardHeight,
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with rounded top corners
          Container(
            height: cardHeight * 0.35, // ~35% of card height for image
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              image: DecorationImage(
                image: NetworkImage(data.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Content section with padding
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(cardWidth * 0.065), // Dynamic padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title section
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 18, // Fixed 18px
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: cardHeight * 0.008),

                  // Subtitle section
                  Text(
                    data.subtitle,
                    style: const TextStyle(
                      fontSize: 18, // Fixed 18px
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(height: cardHeight * 0.015),

                  // Distance and category row
                  Row(
                    children: [
                      Text(
                        data.distance,
                        style: const TextStyle(
                          fontSize: 14, // Fixed 14px
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
                          fontSize: 14, // Fixed 14px
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: cardHeight * 0.025),

                  // Description section with scrollable text
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        data.description,
                        style: const TextStyle(
                          fontSize: 12, // Fixed 12px
                          color: Colors.black87,
                          height: 1.4, // Line height for better readability
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),

                  SizedBox(height: cardHeight * 0.025),

                  // Action buttons row with loading states
                  Obx(
                    () => Row(
                      children: [
                        // UPI Icon - fixed at leftmost position
                        SvgPicture.asset('assets/icons/upi.svg'),

                        SizedBox(width: screenWidth * 0.02),

                        // Visit Website button using CustomButton - takes maximum space
                        Expanded(
                          flex: 1,
                          child: CustomButton(
                            text:
                                controller.isLoading.value
                                    ? 'Loading...'
                                    : 'Visit Website',
                            onPressed:
                                () => controller.visitWebsite(data.websiteUrl),
                            width:
                                null, // Let it expand to maximum available space
                            height: cardHeight * 0.063,
                            fontSize:
                                screenWidth < 360
                                    ? 10
                                    : (screenWidth < 600 ? 12 : 14),
                            fontWeight: FontWeight.w500,
                            backgroundColor: const Color(0xFFFF6B6B),
                            borderRadius: 10,
                            isOutlined: true,
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                              vertical: cardHeight * 0.015,
                            ),
                          ),
                        ),

                        SizedBox(width: screenWidth * 0.02),

                        // Pay button using CustomButton - takes maximum space
                        Expanded(
                          flex: 1,
                          child: CustomButton(
                            text:
                                controller.isProcessingPayment.value
                                    ? 'Processing...'
                                    : 'Pay',
                            onPressed: () => controller.handlePayment(),
                            width:
                                null, // Let it expand to maximum available space
                            height: cardHeight * 0.063,
                            fontSize:
                                screenWidth < 360
                                    ? 12
                                    : (screenWidth < 600 ? 14 : 16),
                            fontWeight: FontWeight.w600,
                            textColor: Colors.white,
                            backgroundColor: const Color(0xFFFF6B6B),
                            borderRadius: 10,
                            isOutlined: false,
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                              vertical: cardHeight * 0.015,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
