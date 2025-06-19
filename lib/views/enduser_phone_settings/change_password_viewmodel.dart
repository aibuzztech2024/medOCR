// ========================================================================================
// VIEW MODEL (CONTROLLER): Business logic and state management layer using GetX
// ========================================================================================

import 'package:avatar/views/enduser_phone_settings/change_password_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller class that manages the business logic for password change functionality
/// This class acts as an intermediary between the View and Model, handling user interactions
/// and form state management using GetX's reactive state management
class ChangePasswordController extends GetxController {
  // Private instance of the model to manage form data
  final ChangePasswordModel _model = ChangePasswordModel();

  // Text controllers for managing TextField input and state
  // Note: currentPasswordController is removed since we're displaying instead of inputting
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();

  // Reactive variables using GetX for automatic UI updates
  /// Reactive boolean indicating if the form is valid
  /// Updates automatically when any password field changes
  RxBool get isFormValid => _model.isFormValid.obs;

  /// Reactive boolean indicating if passwords match
  /// Updates automatically when password fields change
  RxBool get doPasswordsMatch => _model.doPasswordsMatch.obs;

  /// Gets the current password display value (masked)
  String get currentPasswordDisplay => _model.currentPasswordDisplay;

  /// Loading state for password change operation
  /// Used to show loading indicators during API calls
  final RxBool isLoading = false.obs;

  /// Controller initialization - sets up listeners and loads current password
  /// Called automatically when the controller is first created by GetX
  @override
  void onInit() {
    super.onInit();
    _loadCurrentPassword();
    _setupTextFieldListeners();
  }

  /// Loads the current password from storage or API
  /// In a real app, this would fetch from secure storage or user preferences
  void _loadCurrentPassword() {
    // TODO: Load actual current password from secure storage
    // For demo purposes, setting a placeholder
    _model.currentPassword = 'myCurrentPassword123';
    update(); // Notify UI to show the loaded password
  }

  /// Sets up listeners for text controllers to synchronize with the model
  /// This ensures that any change in the text fields immediately updates the underlying model
  /// and triggers reactive UI updates through GetX's update mechanism
  void _setupTextFieldListeners() {
    // Listen to new password changes
    newPasswordController.addListener(() {
      _model.newPassword = newPasswordController.text;
      update(); // Notify GetX to update dependent UI components
    });

    // Listen to retype password changes
    retypePasswordController.addListener(() {
      _model.retypePassword = retypePasswordController.text;
      update(); // Notify GetX to update dependent UI components
    });
  }

  /// Handles the password change submission logic
  /// This method integrates with GetX's reactive state and shows loading states
  /// Returns a Future<bool> indicating success or failure of the operation
  Future<bool> changePassword() async {
    // Validate form before proceeding
    if (!_model.isFormValid) {
      _showErrorSnackbar('Please fill in all password fields');
      return false;
    }

    // Validate password matching
    if (!_model.doPasswordsMatch) {
      _showErrorSnackbar('New passwords do not match');
      return false;
    }

    try {
      // Set loading state to show progress indicators
      isLoading.value = true;

      // TODO: Implement actual password change logic here
      // This would typically involve calling a repository or service
      // Example: await _authRepository.changePassword(_model.currentPassword, _model.newPassword);

      // Simulate async operation (replace with actual API call)
      await Future.delayed(const Duration(seconds: 1));

      // Show success message using GetX snackbar
      _showSuccessSnackbar('Password changed successfully');

      // Clear form on successful change
      _clearForm();

      // Navigate back to previous screen
      Get.back();

      return true;
    } catch (e) {
      // Handle errors appropriately with user-friendly messages
      _showErrorSnackbar('Failed to change password. Please try again.');
      return false;
    } finally {
      // Always reset loading state
      isLoading.value = false;
    }
  }

  /// Shows success snackbar using GetX's built-in snackbar system
  /// [message] - Success message to display to the user
  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Shows error snackbar using GetX's built-in snackbar system
  /// [message] - Error message to display to the user
  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Clears all form fields and resets the model state
  /// Also clears the text controllers to update the UI
  void _clearForm() {
    // Don't clear current password as it's loaded from storage
    _model.newPassword = '';
    _model.retypePassword = '';
    newPasswordController.clear();
    retypePasswordController.clear();
    update(); // Notify GetX of the cleared state
  }

  /// Cleanup method to dispose of text controllers and prevent memory leaks
  /// Called automatically by GetX when the controller is removed from memory
  @override
  void onClose() {
    newPasswordController.dispose();
    retypePasswordController.dispose();
    super.onClose();
  }
}
