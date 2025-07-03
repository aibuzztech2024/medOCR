import 'package:avatar/views/donate/widgets/recent_donation_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentDonations extends StatelessWidget {
  RecentDonations({super.key});
  final RecentDonationViewModel recentDonationController = Get.put(
    RecentDonationViewModel(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recent Donations')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() {
            return Column(
              children:
                  recentDonationController.donations
                      .take(2)
                      .map((donation) => RecentDonationCard(donation: donation))
                      .toList(),
            );
          }),
        ],
      ),
    );
  }
}
