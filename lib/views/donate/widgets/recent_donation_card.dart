import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/donate/recent_donation_model.dart';

class RecentDonationCard extends StatelessWidget {
  final RecentDonationModel donation;

  const RecentDonationCard({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    final screenHeight = Get.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.015,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Row with image, org info, and donation details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Organization image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    donation.organizationLogoUrl,
                    width: screenWidth * 0.15,
                    height: screenWidth * 0.15,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: screenWidth * 0.035),

                /// Org details (category, name)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        donation.category,
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.004),
                      Text(
                        donation.organizationName,
                        style: TextStyle(
                          fontSize: screenWidth * 0.036,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Right-side: Date, Amount, Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      donation.donationDate,
                      style: TextStyle(
                        fontSize: screenWidth * 0.032,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.004),
                    Text(
                      "₹${donation.amount.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.006),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.004,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        donation.status,
                        style: TextStyle(
                          fontSize: screenWidth * 0.028,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.010),

            /// Row with buttons (aligned to left start of image)
            Row(
              children: [
                Flexible(
                  child: _buildBillButton("Platform Bill", screenWidth),
                ),
                SizedBox(width: screenWidth * 0.02),
                Flexible(
                  child: _buildBillButton("Donation Bill", screenWidth),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable styled bill button
  Widget _buildBillButton(String text, double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenWidth * 0.01,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9E9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE8EAD4),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: screenWidth * 0.032,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: screenWidth * 0.015),
          Icon(
            Icons.remove_red_eye_outlined,
            size: screenWidth * 0.045,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
}
