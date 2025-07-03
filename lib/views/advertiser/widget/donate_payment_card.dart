import 'package:avatar/views/advertiser/donate/donation_detailed_read_more_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Payment card widget that displays donation organization details
class DonationPaymentCard extends StatelessWidget {
  final DonationCardModel1 donation;
  const DonationPaymentCard({Key? key, required this.donation})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive dimensions
    double cardWidth = _getCardWidth(screenWidth);
    double cardHeight = _getCardHeight(screenHeight);
    double imageHeight = cardHeight * 0.7; // 70% of card height for image

    return Container(
      width: cardWidth,
      height: cardHeight,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Organization image container
          Container(
            width: cardWidth,
            height: imageHeight,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(donation.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Organization details container
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(_getPadding(screenWidth)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Organization title
                      Text(
                        donation.title,
                        style: TextStyle(
                          fontSize: _getTitleFontSize(screenWidth),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2D3748),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      // Organization description
                      Text(
                        donation.description,
                        style: TextStyle(
                          fontSize: _getDescriptionFontSize(screenWidth),
                          color: const Color(0xFF718096),
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Calculate card width based on screen width
  double _getCardWidth(double screenWidth) {
    if (screenWidth < 480) {
      // Mobile: Use most of screen width with margins
      return screenWidth * 0.9;
    } else if (screenWidth < 768) {
      // Small tablet: Use 80% of screen width
      return screenWidth * 0.8;
    } else if (screenWidth < 1024) {
      // Large tablet: Fixed width but responsive
      return 400;
    } else {
      //Original fixed width
      return 366;
    }
  }

  /// Calculate card height based on screen height
  double _getCardHeight(double screenHeight) {
    if (screenHeight < 600) {
      // Small screens: Use percentage of screen height
      return screenHeight * 0.6;
    } else if (screenHeight < 800) {
      // Medium screens
      return screenHeight * 0.45;
    } else {
      // Large screens: Original height or percentage, whichever is smaller
      return screenHeight * 0.4 > 364 ? 364 : screenHeight * 0.4;
    }
  }

  /// Get responsive padding
  double _getPadding(double screenWidth) {
    if (screenWidth < 480) {
      return 12.0;
    } else if (screenWidth < 768) {
      return 14.0;
    } else {
      return 16.0;
    }
  }

  /// Get responsive title font size
  double _getTitleFontSize(double screenWidth) {
    if (screenWidth < 480) {
      return 16.0;
    } else if (screenWidth < 768) {
      return 17.0;
    } else {
      return 18.0;
    }
  }

  /// Get responsive description font size
  double _getDescriptionFontSize(double screenWidth) {
    if (screenWidth < 480) {
      return 12.0;
    } else if (screenWidth < 768) {
      return 12.5;
    } else {
      return 13.0;
    }
  }
}
