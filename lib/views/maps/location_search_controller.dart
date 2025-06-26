import 'dart:async';
import 'package:get/get.dart';
import '../services/location_service.dart';
import '../views/maps/json_data_model.dart';

class LocationSearchController extends GetxController {
  final LocationService _locationService = LocationService();
  final startLocationResults = <Features>[].obs;
  final destinationResults = <Features>[].obs;
  final isLoadingStart = false.obs;
  final isLoadingDestination = false.obs;

  Timer? _startLocationDebounce;
  Timer? _destinationDebounce;

  void searchStartLocation(String query) {
    if (_startLocationDebounce?.isActive ?? false) {
      _startLocationDebounce!.cancel();
    }

    // Clear results if query is empty
    if (query.isEmpty) {
      startLocationResults.clear();
      return;
    }

    _startLocationDebounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        isLoadingStart.value = true;
        final results = await _locationService.searchLocations(query);
        if (results.features != null && results.features!.isNotEmpty) {
          startLocationResults.value = results.features!;
        } else {
          startLocationResults.clear();
        }
      } catch (e) {
        print('Error searching start location: $e');
        startLocationResults.clear();
      } finally {
        isLoadingStart.value = false;
      }
    });
  }

  void searchDestination(String query) {
    if (_destinationDebounce?.isActive ?? false) {
      _destinationDebounce!.cancel();
    }

    // Clear results if query is empty
    if (query.isEmpty) {
      destinationResults.clear();
      return;
    }

    _destinationDebounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        isLoadingDestination.value = true;
        final results = await _locationService.searchLocations(query);
        if (results.features != null && results.features!.isNotEmpty) {
          destinationResults.value = results.features!;
        } else {
          destinationResults.clear();
        }
      } catch (e) {
        print('Error searching destination: $e');
        destinationResults.clear();
      } finally {
        isLoadingDestination.value = false;
      }
    });
  }

  @override
  void onClose() {
    _startLocationDebounce?.cancel();
    _destinationDebounce?.cancel();
    super.onClose();
  }
}
