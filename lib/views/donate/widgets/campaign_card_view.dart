import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/donate/campaign_model.dart';
import '../../../viewModels/donate/campaign_view_model.dart';

class CampaignCardView extends StatefulWidget {
  final CampaignModel campaign;

  // Constructor requires a campaign object
  const CampaignCardView({Key? key, required this.campaign}) : super(key: key);

  @override
  State<CampaignCardView> createState() => _CampaignCardViewState();
}

class _CampaignCardViewState extends State<CampaignCardView> {
  // Track bookmark toggle state
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    final campaign = widget.campaign; // Access campaign data
    final screenWidth = Get.width;   // Screen width for responsive design
    final screenHeight = Get.height; // Screen height for responsive design

    // Calculate image height with max limit of 250 pixels
    final imageHeight = (screenHeight * 0.35) > 250 ? 250.0 : (screenHeight * 0.35);

    // Y-offset to lift the card a bit over the image
    final translateOffsetY = -imageHeight * 0.15;

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.01), // Top spacing

        // Stack for campaign image with bookmark icon overlay
        Stack(
          children: [
            // Rounded corners image of the campaign
            ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.06),
              child: Image.asset(
                campaign.imageUrl,
                width: screenWidth * 0.9,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),

            // Positioned bookmark icon on top-right of the image
            Positioned(
              top: screenHeight * 0.015,
              right: screenWidth * 0.03,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isBookmarked = !isBookmarked; // Toggle bookmark state
                  });
                },
                borderRadius: BorderRadius.circular(screenWidth * 0.075),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.015),
                  child: Icon(
                    isBookmarked
                        ? Icons.bookmark_rounded    // Filled bookmark when active
                        : Icons.bookmark_outline_rounded, // Outline bookmark when inactive
                    color: Colors.white,
                    size: screenWidth * 0.06,
                  ),
                ),
              ),
            ),
          ],
        ),

        // Card containing campaign details, slightly overlapping image using Transform.translate
        Transform.translate(
          offset: Offset(0, translateOffsetY), // Lift card over image
          child: Container(
            width: screenWidth * 0.85,
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x33000000),  // Transparent black shadow
                  blurRadius: screenWidth * 0.04,
                  offset: Offset(0, screenHeight * 0.01),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column with title, location, and progress info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Campaign title text
                      Text(
                        campaign.title,
                        style: TextStyle(
                          fontSize: screenWidth * 0.0425,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.0075),

                      // Row with location icon and location text
                      Row(
                        children: [
                          Icon(Icons.location_on, size: screenWidth * 0.04, color: Colors.grey),
                          SizedBox(width: screenWidth * 0.01),
                          Flexible(
                            child: Text(
                              campaign.location,
                              style: TextStyle(
                                fontSize: screenWidth * 0.034,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis, // Handle long locations gracefully
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.0125),

                      // Text showing collected amount and days left with styling
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '₹${campaign.amountCollected.toStringAsFixed(0)} ',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            TextSpan(
                              text: 'Collected | ${campaign.daysLeft} Days Left',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: screenWidth * 0.03),

                // Right column with circular progress and distance info
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Circular progress indicator showing campaign progress percentage
                    SizedBox(
                      width: screenWidth * 0.12,
                      height: screenWidth * 0.12,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: campaign.progressPercent / 100, // Value between 0 and 1
                            backgroundColor: Colors.grey.shade300,
                            color: Colors.orange,
                            strokeWidth: screenWidth * 0.0125,
                          ),
                          Center(
                            child: Text(
                              '${campaign.progressPercent}%',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.03,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.017),

                    // Distance text
                    Text(
                      '${campaign.distanceKm} km away',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
