import 'package:avatar/views/advertiser/donate/donation_detailed_read_more_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:avatar/views/advertiser/widget/donation_read_more_card.dart';

/// Updated DonationCardReadMorePage to use the controller
class DonationCardReadMorePage extends StatelessWidget {
  const DonationCardReadMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DonationCardReadMoreController());

    return Scaffold(
      appBar: AppBar(title: const Text('Donation Details')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Obx(
            () =>
                // Show loading indicator if any operation is in progress
                controller.isAnyLoading
                    ? const CircularProgressIndicator()
                    : DonationCard(data: controller.currentDonation),
          ),
        ),
      ),
    );
  }
}
