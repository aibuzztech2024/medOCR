import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/donate/campaign_model.dart';

class DonateCampaignCard extends StatelessWidget {
  final CampaignModel campaign;

  const DonateCampaignCard({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    final screenHeight = Get.height;
    final RxBool isBookmarked = false.obs;

    return Container(
      margin: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Image with Bookmark Icon ---
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenWidth * 0.04),
                  topRight: Radius.circular(screenWidth * 0.04),
                ),
                child: Image.asset(
                  campaign.imageUrl,
                  width: double.infinity,
                  height: screenHeight * 0.23,
                  fit: BoxFit.cover,
                ),
              ),
              Obx(() => Positioned(
                top: screenHeight * 0.015,
                right: screenWidth * 0.03,
                child: GestureDetector(
                  onTap: () => isBookmarked.toggle(),
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.015),
                    child: Icon(
                      isBookmarked.value
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_outline_rounded,
                      color: Colors.white,
                      size: screenWidth * 0.055,
                    ),
                  ),
                ),
              )),
            ],
          ),

          // --- Text & Progress Content ---
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Title, Location, Amount, Days ---
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign.title,
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.006),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: screenWidth * 0.04, color: Colors.grey),
                          SizedBox(width: screenWidth * 0.01),
                          Flexible(
                            child: Text(
                              campaign.location,
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: Colors.grey.shade700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.012),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '₹${campaign.amountCollected.toStringAsFixed(0)} ',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: screenWidth * 0.037,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'Collected | ${campaign.daysLeft} Days Left',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: screenWidth * 0.02),

                // --- Progress Circle ---
                Column(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.14,
                      height: screenWidth * 0.14,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: campaign.progressPercent / 100,
                            backgroundColor: Colors.grey.shade300,
                            color: Colors.orange,
                            strokeWidth: screenWidth * 0.015,
                          ),
                          Center(
                            child: Text(
                              '${campaign.progressPercent}%',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // --- Buttons: Read More | Donate Now ---
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.04,
              right: screenWidth * 0.04,
              bottom: screenHeight * 0.02,
            ),
            child: Row(
              children: [
                // Read More Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Handle Read More tap
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                      backgroundColor: const Color(0xFFFFF8E9),
                      side: const BorderSide(color: Color(0xFFFF8E9)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                    ),
                    child: Text(
                      'Read More >>',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: screenWidth * 0.04),

                // Donate Now Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Handle Donate Now tap
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                    ),
                    child: Text(
                      'Donate Now',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
