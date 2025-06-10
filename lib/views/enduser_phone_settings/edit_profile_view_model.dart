// ============================================================================
// VIEW MODEL: Business logic and state management
// ============================================================================
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// ViewModel for managing account information state and operations
class EditProfileViewModel extends GetxController {
  // Text controllers for form fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  // Reactive state for selected country
  final selectedCountry = Rx<Country?>(null);

  @override
  void onInit() {
    super.onInit();
    _initializeDefaultValues();
  }

  @override
  void onClose() {
    _disposeControllers();
    super.onClose();
  }

  /// Initialize form with default values
  void _initializeDefaultValues() {
    final args = Get.arguments;
    if (args != null) {
      nameController.text = args['name'] ?? '';
      emailController.text = args['email'] ?? '';
      // Phone number will be handled separately if needed
    }
  }

  /// Clean up text controllers
  void _disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  /// Handle country selection
  void onCountrySelected(Country country) {
    selectedCountry.value = country;
  }
}
