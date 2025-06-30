import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Model class representing the donation card data
class DonationCardModel {
  final String organizationName;
  final String campaignTitle;
  final String dateTime;
  final String amount;

  DonationCardModel({
    required this.organizationName,
    required this.campaignTitle,
    required this.dateTime,
    required this.amount,
  });
}

/// ViewModel managing the donation card state
class DonationCardViewModel extends GetxController {
  final donation = DonationCardModel(
    organizationName: 'SMILE FOUNDATION',
    campaignTitle: 'Give a Smile, Change a Life',
    dateTime: '20 Mar 2025, 10:30 AM',
    amount: '24,000',
  ).obs;
}

/// DonationCardView widget - dynamic and responsive card
class DonationCardView extends StatelessWidget {
  final DonationCardViewModel viewModel = Get.put(DonationCardViewModel());

  DonationCardView({super.key});

  @override
  Widget build(BuildContext context) {
    /// Calculate dynamic sizes based on screen dimensions
    final double cardWidth = Get.width * 0.92;
    final double cardHeight = Get.height * 0.18;

    final double paddingHorizontal = cardWidth * 0.04;
    final double paddingVertical = cardHeight * 0.1;
    final double fontOrgName = cardWidth * 0.035;
    final double fontCampaignTitle = cardWidth * 0.045;
    final double fontAmount = cardWidth * 0.055;

    return Obx(() {
      final model = viewModel.donation.value;

      /// Main container with padding, border, and rounded corners
      return Container(
        width: cardWidth,
        // Removed fixed height to avoid overflow issues
        padding: EdgeInsets.fromLTRB(
          paddingHorizontal,
          paddingVertical,
          paddingHorizontal,
          paddingVertical * 0.2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0x425182E3), width: 1),
        ),

        /// Content arranged vertically, centered horizontally and vertically
        child: Column(
          mainAxisSize: MainAxisSize.min, // Take only needed height
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Organization Name in uppercase, single line
            Text(
              model.organizationName.toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                fontSize: fontOrgName,
                height: 1.2,
                letterSpacing: 0,
                color: const Color(0xFF6B79F5),
              ),
            ),

            const SizedBox(height: 8),

            /// Campaign Title
            Flexible(
              child: Text(
                model.campaignTitle,
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: fontCampaignTitle,
                  height: 1.2,
                  letterSpacing: 0,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 4),

            /// Date and time with lighter font weight
            Text(
              model.dateTime,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1.2,
                letterSpacing: 0,
                color: Color(0xFF555555),
              ),
            ),

            const SizedBox(height: 20),

            /// Donation amount in bold
            Text(
              model.amount,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.bold,
                fontSize: fontAmount,
                color: const Color(0xFF1F1F1F),
              ),
            ),
          ],
        ),
      );
    });
  }
}
