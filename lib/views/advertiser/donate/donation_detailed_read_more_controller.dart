import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar/views/advertiser/widget/donation_read_more_card.dart';

class DonationCardReadMoreController extends GetxController {
  // Observable states
  var isLoading = false.obs;
  var isProcessingPayment = false.obs;

  // Sample donation data - in real app, this would come from API/repository
  late DonationCardModel donationData;

  @override
  void onInit() {
    super.onInit();
    _initializeDonationData();
  }

  /// Initialize mock donation data
  void _initializeDonationData() {
    donationData = DonationCardModel(
      imageUrl:
          'https://img.freepik.com/free-photo/little-girl-with-backpack-studio_23-2147851792.jpg?semt=ais_hybrid&w=740',
      title: 'Help Flood Victims',
      subtitle: 'Urgent Aid Needed',
      distance: '3 km away',
      category: 'Disaster Relief',
      description:
          'Thousands of people have been displaced due to the recent floods. Your donations will go towards food, shelter, and essential supplies. Every contribution counts. We are working with local authorities to ensure aid reaches those who need it most.',
      websiteUrl: 'https://example.com/donate',
    );
  }

  /// Handle website visit action
  // Future<void> visitWebsite(String url) async {
  //   try {
  //     isLoading.value = true;

  //     final Uri uri = Uri.parse(url);

  //     if (await canLaunchUrl(uri)) {
  //       await launchUrl(uri, mode: LaunchMode.externalApplication);
  //     } else {
  //       _showErrorSnackbar('Unable to open website');
  //     }
  //   } catch (e) {
  //     _showErrorSnackbar('Error opening website: ${e.toString()}');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  /// Handle payment process
  Future<void> handlePayment() async {
    try {
      isProcessingPayment.value = true;

      // Show payment options dialog
      await _showPaymentDialog();
    } catch (e) {
      _showErrorSnackbar('Payment error: ${e.toString()}');
    } finally {
      isProcessingPayment.value = false;
    }
  }

  /// Show payment options dialog
  Future<void> _showPaymentDialog() async {
    await Get.dialog(
      AlertDialog(
        title: const Text('Select Payment Method'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPaymentOption('UPI Payment', Icons.payment),
            _buildPaymentOption('Credit/Debit Card', Icons.credit_card),
            _buildPaymentOption('Net Banking', Icons.account_balance),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        ],
      ),
    );
  }

  /// Build payment option widget
  Widget _buildPaymentOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Get.back();
        _processPayment(title);
      },
    );
  }

  /// Process selected payment method
  void _processPayment(String paymentMethod) {
    // In real app, integrate with payment gateway
    _showSuccessSnackbar('Payment initiated via $paymentMethod');
  }

  /// Show success message
  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  /// Show error message
  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  /// Get current donation data
  DonationCardModel get currentDonation => donationData;

  /// Check if any loading state is active
  bool get isAnyLoading => isLoading.value || isProcessingPayment.value;
}
