import 'package:get/get.dart';

class EmailSupportViewModel extends GetxController {
  // Observable variables
  final RxString emailAddress = ''.obs;
  final RxString description = ''.obs;
  final RxBool isLoading = false.obs;

  // Default support email
  final String defaultSupportEmail = 'contactsupport@gmail.com';

  @override
  void onInit() {
    super.onInit();
    // Initialize with default email
    _initializeData();
  }

  // Initialize data
  void _initializeData() {
    emailAddress.value = defaultSupportEmail;
  }

  // Handle email address change
  void onEmailChanged(String value) {
    emailAddress.value = value;
  }

  // Handle description change
  void onDescriptionChanged(String value) {
    description.value = value;
  }

  // Validate form data
  bool validateForm() {
    if (emailAddress.isEmpty) {
      Get.snackbar('Error', 'Email address is required');
      return false;
    }

    if (!GetUtils.isEmail(emailAddress.value)) {
      Get.snackbar('Error', 'Please enter a valid email address');
      return false;
    }

    if (description.isEmpty) {
      Get.snackbar('Error', 'Description is required');
      return false;
    }

    return true;
  }

  // Send email support ticket
  Future<void> sendSupportEmail() async {
    if (!validateForm()) {
      return;
    }

    try {
      isLoading.value = true;
      // TODO: Implement API call to send email
      await _sendEmailToSupport();

      Get.snackbar('Success', 'Support email sent successfully');
      Get.back(); // Navigate back after successful submission
    } catch (e) {
      Get.snackbar('Error', 'Failed to send email: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // API call to send email
  Future<void> _sendEmailToSupport() async {
    // TODO: Implement actual email sending logic
    await Future.delayed(Duration(seconds: 2)); // Simulate API delay
  }

  // Reset form
  void resetForm() {
    emailAddress.value = defaultSupportEmail;
    description.value = '';
  }

  // Copy support email to clipboard
  void copySupportEmail() {
    // TODO: Implement clipboard functionality
    Get.snackbar('Copied', 'Support email copied to clipboard');
  }

  @override
  void onClose() {
    // Clean up resources if needed
    super.onClose();
  }
}
