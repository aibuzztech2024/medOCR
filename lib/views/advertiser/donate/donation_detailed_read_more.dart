import 'package:avatar/views/advertiser/donate/donation_detailed_read_more_controller.dart';
import 'package:avatar/views/advertiser/widget/donation_read_more_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Page to display detailed donation information using DonationReadMoreCard
/// Receives data from OrganizationController via Get.arguments
class DonationCardReadMorePage extends StatelessWidget {
  const DonationCardReadMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller which will handle data from arguments
    final controller = Get.put(DonationCardReadMoreController());

    return Scaffold(
      // Dynamic app bar title based on the donation data
      appBar: AppBar(
        title: Text(
          controller.pageTitle,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        centerTitle: true,
      ),

      backgroundColor: Colors.grey[50],

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Main donation read more card
              DonationReadMoreCard(data: controller.currentDonation),

              const SizedBox(height: 20),

              // Optional: Loading indicator for async operations
              Obx(() {
                if (controller.isAnyLoading) {
                  return Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: const Column(
                      children: [
                        CircularProgressIndicator(color: Color(0xFFFF6B6B)),
                        SizedBox(height: 8),
                        Text(
                          'Processing...',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
