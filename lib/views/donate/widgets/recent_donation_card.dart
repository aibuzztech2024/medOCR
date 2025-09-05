import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// --- MODEL ------------------------------------------------------------------
/// Represents a recent donation entry
class RecentDonationModel {
  final String category;
  final String organizationName;
  final String organizationLogoUrl;
  final String donationDate;
  final double amount;
  final String status;

  RecentDonationModel({
    required this.category,
    required this.organizationName,
    required this.organizationLogoUrl,
    required this.donationDate,
    required this.amount,
    required this.status,
  });
}

/// --- VIEWMODEL -------------------------------------------------------------
/// Manages donation list and data logic using GetX
class RecentDonationViewModel extends GetxController {
  // Observable list of donations
  var donations = <RecentDonationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDonations(); // Load data when ViewModel is initialized
  }

  /// Loads mock donation data (can be replaced with API call)
  void loadDonations() {
    donations.value = [
      RecentDonationModel(
        category: "Healthcare",
        organizationName: "Bharat Seva Mandal",
        organizationLogoUrl: "assets/images/campaign.jpg",
        donationDate: "10/06/25, 12:45",
        amount: 10000,
        status: "Successful",
      ),
      RecentDonationModel(
        category: "Education",
        organizationName: "Helping Hands Trust",
        organizationLogoUrl: "assets/images/campaign.jpg",
        donationDate: "20/05/25, 14:30",
        amount: 5000,
        status: "Successful",
      ),
    ];
  }
}

/// --- CARD WIDGET -----------------------------------------------------------
/// Displays a single donation record in a stylized card
class RecentDonationCard extends StatelessWidget {
  final RecentDonationModel donation;

  const RecentDonationCard({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    final screenHeight = Get.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.012,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row - Logo, Org Info, and Right Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Organization Logo
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

                /// Organization Info
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

                /// Right-aligned: Date, Amount, Status
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

            SizedBox(height: screenHeight * 0.012),

            /// Action buttons
            Row(
              children: [
                Flexible(child: _buildBillButton("Platform Bill", screenWidth)),
                SizedBox(width: screenWidth * 0.02),
                Flexible(child: _buildBillButton("Donation Bill", screenWidth)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable small outlined button with eye icon
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

/// --- MAIN VIEW (Recent Donation Page) --------------------------------------
/// Displays the full list of recent donations from ViewModel
class RecentDonationPage extends StatelessWidget {
  final RecentDonationViewModel donationController =
  Get.put(RecentDonationViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recent Donations"),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
      ),
      body: Obx(() {
        final donations = donationController.donations;

        if (donations.isEmpty) {
          return const Center(child: Text("No donations yet."));
        }

        return ListView.builder(
          itemCount: donations.length,
          itemBuilder: (_, index) {
            return RecentDonationCard(donation: donations[index]);
          },
        );
      }),
    );
  }
}
