import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/location_search_controller.dart';

class LocationSelectionViewModel extends GetxController {
  late final LocationSearchController locationSearchController;
  late final TextEditingController startLocationController;
  late final TextEditingController destinationController;

  // Default locations data
  final List<Map<String, String>> defaultLocations = [
    {
      'title': 'Base Hospital',
      'subtitle': 'Sardar Patel Marg, Lucknow, Uttar Pradesh',
    },
    {
      'title': 'Delulu Hospital',
      'subtitle': 'Telibagh, Lucknow, Uttar pradesh',
    },
    {'title': 'Mr Brown Hospital', 'subtitle': 'Uttam Nagar, New Delhi'},
    {'title': 'Crazy Chai Lab', 'subtitle': 'Sector 117, Noida, Uttar Pradesh'},
  ];

  @override
  void onInit() {
    super.onInit();
    locationSearchController = Get.put(LocationSearchController());
    startLocationController = TextEditingController();
    destinationController = TextEditingController();
  }

  @override
  void onClose() {
    startLocationController.dispose();
    destinationController.dispose();
    super.onClose();
  }

  // Getters for reactive state
  bool get isLoadingStart => locationSearchController.isLoadingStart.value;
  bool get isLoadingDestination =>
      locationSearchController.isLoadingDestination.value;
  List get startLocationResults =>
      locationSearchController.startLocationResults;
  List get destinationResults => locationSearchController.destinationResults;

  // Methods
  void onStartLocationChanged(String query) {
    locationSearchController.searchStartLocation(query);
  }

  void onDestinationChanged(String query) {
    locationSearchController.searchDestination(query);
  }

  void onSwapPressed() {
    // Swap locations logic will go here
  }

  void onLocationSelected(String title, String subtitle) {
    // Handle location selection
    if (startLocationController.text.isNotEmpty) {
      startLocationController.text = title;
      locationSearchController.startLocationResults.clear();
    } else {
      destinationController.text = title;
      locationSearchController.destinationResults.clear();
    }
    // You can add navigation logic here if needed
  }

  void onCurrentLocationTap() {
    // Current location logic will go here
  }

  void onMoreHistoryTap() {
    // Show more history logic will go here
  }

  void onLocationTap(String title, String subtitle) {
    // Location selection logic will go here
  }

  // Computed properties
  List get activeResults {
    return startLocationController.text.isNotEmpty
        ? startLocationResults
        : destinationResults;
  }

  bool get isStartLocationActive => startLocationController.text.isNotEmpty;

  bool get hasSearchResults => activeResults.isNotEmpty;

  bool get isSearchActive =>
      startLocationController.text.isNotEmpty ||
      destinationController.text.isNotEmpty;

  bool get isLoading => isLoadingStart || isLoadingDestination;
}
