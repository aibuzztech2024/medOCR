import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/donate/campaign_model.dart';
import '../../../viewModels/donate/campaign_view_model.dart';

class CampaignCardView extends StatelessWidget {
  CampaignCardView({Key? key}) : super(key: key);

  final CampaignViewModel campaignVM = Get.find<CampaignViewModel>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    final screenHeight = Get.height;
    final imageHeight = (screenHeight * 0.35) > 250 ? 250.0 : (screenHeight * 0.35);
    final translateOffsetY = -imageHeight * 0.15;

    return Obx(() {
      final CampaignModel campaign = campaignVM.campaign.value;

      return Column(
        children: [
          SizedBox(height: screenHeight * 0.01),

          // Image + Bookmark
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.06),
                child: Image.asset(
                  campaign.imageUrl,
                  width: screenWidth * 0.9,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: screenHeight * 0.015,
                right: screenWidth * 0.03,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.015),
                    child: Icon(
                      Icons.bookmark_outline_rounded,
                      color: Colors.white,
                      size: screenWidth * 0.06,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Card overlapping image
          Transform.translate(
            offset: Offset(0, translateOffsetY),
            child: Container(
              width: screenWidth * 0.85,
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x33000000),
                    blurRadius: screenWidth * 0.04,
                    offset: Offset(0, screenHeight * 0.01),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          campaign.title,
                          style: TextStyle(
                            fontSize: screenWidth * 0.0425,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.0075),
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
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.0125),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '₹${campaign.amountCollected.toStringAsFixed(0)} ',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3AAFA9),

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

                  // Right: progress & distance
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                              value: campaign.progressPercent / 100,
                              backgroundColor: Colors.grey.shade300,
                              color: const Color(0xFF3AAFA9),
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
    });
  }
}
