import 'package:avatar/views/advertiser/donate/donation_payment.dart';
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

  /// Handle payment process - Navigate to DonationPaymentScreen with data
  Future<void> handlePayment() async {
    try {
      isProcessingPayment.value = true;

      // Add debug print to verify method is called
      print("🔥 handlePayment called - Starting navigation process");

      // Convert current DonationCardModel to DonationCardModel1 format
      final paymentData = DonationCardModel1(
        imageUrl: donationData.imageUrl,
        title: donationData.title,
        subtitle: donationData.subtitle,
        distance: donationData.distance,
        category: donationData.category,
        description: donationData.description,
        websiteUrl: donationData.websiteUrl,
      );

      print("🔥 Payment data created: ${paymentData.title}");

      // Navigate to payment screen with donation data as arguments
      await Get.to(
        () => DonationPaymentScreen(),
        arguments: paymentData,
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );

      print("🔥 Navigation completed successfully");
    } catch (e) {
      print("🔥 Navigation error: ${e.toString()}");
      _showErrorSnackbar('Navigation error: ${e.toString()}');
    } finally {
      isProcessingPayment.value = false;
    }
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

/// Data model for DonationPaymentScreen (matches your provided model)
class DonationCardModel1 {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String distance;
  final String category;
  final String description;
  final String websiteUrl;

  DonationCardModel1({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.distance,
    required this.category,
    required this.description,
    required this.websiteUrl,
  });
}
