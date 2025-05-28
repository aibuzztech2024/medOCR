import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar/views/advertiser/widget/donation_read_more_card.dart';
import 'package:avatar/views/advertiser/donate/donation_model.dart';

/// Controller for DonationCardReadMorePage that handles data from arguments
class DonationCardReadMoreController extends GetxController {
  // =============================================================================
  // REACTIVE STATE
  // =============================================================================

  /// Loading state for async operations
  var isLoading = false.obs;

  /// Payment processing state
  var isProcessingPayment = false.obs;

  /// The donation/organization data passed from previous screen
  late DonationCardModel donationData;

  // =============================================================================
  // LIFECYCLE METHODS
  // =============================================================================

  @override
  void onInit() {
    super.onInit();
    _initializeDonationData();
  }

  /// Initialize donation data from Get arguments or use fallback
  void _initializeDonationData() {
    // Get the DonationModel passed as argument from OrganizationController
    final DonationModel? passedData = Get.arguments as DonationModel?;

    if (passedData != null) {
      // Convert DonationModel to DonationCardModel
      donationData = _convertToCardModel(passedData);
    } else {
      // Fallback to sample data if no arguments passed
      _createFallbackData();
    }
  }

  /// Convert DonationModel to DonationCardModel format
  DonationCardModel _convertToCardModel(DonationModel donation) {
    return DonationCardModel(
      imageUrl: donation.imageUrl ?? _getDefaultImageUrl(),
      title: donation.title,
      subtitle: donation.address ?? donation.address ?? '',
      distance: donation.distance ?? 'Location not specified',
      category: donation.category ?? 'General',
      description: donation.description ?? '',
      websiteUrl: donation.websiteUrl ?? 'https://example.com/donate',
    );
  }

  /// Create fallback sample data when no arguments are passed
  void _createFallbackData() {
    donationData = DonationCardModel(
      imageUrl: _getDefaultImageUrl(),
      title: 'Help Flood Victims',
      subtitle: 'Urgent Aid Needed',
      distance: '3 km away',
      category: 'Disaster Relief',
      description:
          'Thousands of people have been displaced due to the recent floods. '
          'Your donations will go towards food, shelter, and essential supplies. '
          'Every contribution counts. We are working with local authorities to '
          'ensure aid reaches those who need it most.',
      websiteUrl: 'https://example.com/donate',
    );
  }

  /// Get default image URL for fallback
  String _getDefaultImageUrl() {
    return 'https://img.freepik.com/free-photo/little-girl-with-backpack-studio_23-2147851792.jpg?semt=ais_hybrid&w=740';
  }

  // =============================================================================
  // ACTION HANDLERS
  // =============================================================================

  /// Handle website visit action
  Future<void> visitWebsite(String url) async {
    try {
      isLoading.value = true;

      // Show loading state and simulate navigation
      _showSuccessSnackbar('Opening website: $url');

      // TODO: Implement actual URL launching
      // final Uri uri = Uri.parse(url);
      // if (await canLaunchUrl(uri)) {
      //   await launchUrl(uri, mode: LaunchMode.externalApplication);
      // } else {
      //   _showErrorSnackbar('Unable to open website');
      // }
    } catch (e) {
      _showErrorSnackbar('Error opening website: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

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
        title: Text('Donate to ${donationData.title}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose your preferred payment method:',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
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
      leading: Icon(icon, color: const Color(0xFFFF6B6B)),
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
    _showSuccessSnackbar(
      'Payment initiated via $paymentMethod for ${donationData.title}',
    );
  }

  // =============================================================================
  // UI FEEDBACK METHODS
  // =============================================================================

  /// Show success message
  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
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
      margin: const EdgeInsets.all(16),
    );
  }

  // =============================================================================
  // GETTER METHODS
  // =============================================================================

  /// Get current donation data for the UI
  DonationCardModel get currentDonation => donationData;

  /// Check if any loading state is active
  bool get isAnyLoading => isLoading.value || isProcessingPayment.value;

  /// Get formatted title for app bar
  String get pageTitle => donationData.title;
}
