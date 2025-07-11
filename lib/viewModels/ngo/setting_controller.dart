import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  // Text controllers (no default values)
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final websiteController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  // Assign data after initialization
  void loadInitialData() {
    emailController.text = 'monikasingh@gmail.com';
    phoneController.text = '9892356282';
    websiteController.text = 'monikasingh@gmail.com';
  }

  void updateAccountInfo() async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar("Error", "Please fill all fields properly",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;
      debugPrint("Updating account info...");
      await Future.delayed(const Duration(seconds: 3));
      debugPrint("Email: ${emailController.text}");
      debugPrint("Phone: ${phoneController.text}");
      debugPrint("Website: ${websiteController.text}");

      Get.snackbar("Success", "Account info updated",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      debugPrint("Update failed: $e");
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // =========================================================================
  // PHONE NUMBER HANDLING - Country Code Selection
  // =========================================================================

  /// Handle country code selection from country picker widget
  void onCountryCodeSelected(Country country) {
    // Now you can use country.phoneCode, country.countryCode, etc.
    print('Selected country code: \\${country.phoneCode}');
  }
  @override
  void onInit() {
    super.onInit();
    loadInitialData(); // load values when controller is initialized
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    websiteController.dispose();
    super.onClose();
  }
}

