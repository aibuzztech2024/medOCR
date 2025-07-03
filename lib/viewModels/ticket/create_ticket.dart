import 'package:get/get.dart';

class CreateTicketViewModel extends GetxController {
  // Observable variables
  final RxString selectedIssueType = ''.obs;
  final RxString selectedIssue = ''.obs;
  final RxString issueDescription = ''.obs;
  final RxBool isLoading = false.obs;

  // Dummy data for dropdowns
  final RxList<String> issueTypes =
      <String>[
        'Technical Issue',
        'Account Problem',
        'Billing Issue',
        'Feature Request',
        'Other',
      ].obs;

  final RxList<String> issues =
      <String>[
        'Login Problem',
        'App Crash',
        'Slow Performance',
        'Data Sync Issue',
        'UI/UX Problem',
      ].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize any required data
    _initializeData();
  }

  // Initialize dummy data or fetch from API
  void _initializeData() {
    // TODO: Implement data initialization
  }

  // Handle issue type selection
  void onIssueTypeChanged(String? value) {
    if (value != null) {
      selectedIssueType.value = value;
      // TODO: Update issues list based on selected type
      _updateIssuesForType(value);
    }
  }

  // Handle issue selection
  void onIssueChanged(String? value) {
    if (value != null) {
      selectedIssue.value = value;
    }
  }

  // Handle description change
  void onDescriptionChanged(String value) {
    issueDescription.value = value;
  }

  // Update issues based on selected type
  void _updateIssuesForType(String type) {
    // TODO: Implement logic to filter issues based on type
  }

  // Validate form data
  bool validateForm() {
    // TODO: Implement form validation
    return selectedIssueType.isNotEmpty &&
        selectedIssue.isNotEmpty &&
        issueDescription.isNotEmpty;
  }

  // Submit ticket
  Future<void> submitTicket() async {
    if (!validateForm()) {
      Get.snackbar('Error', 'Please fill all required fields');
      return;
    }

    try {
      isLoading.value = true;
      // TODO: Implement API call to submit ticket
      await _submitTicketToAPI();

      Get.snackbar('Success', 'Ticket created successfully');
      Get.back(); // Navigate back after successful submission
    } catch (e) {
      Get.snackbar('Error', 'Failed to create ticket: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // API call to submit ticket
  Future<void> _submitTicketToAPI() async {
    // TODO: Implement actual API call
    await Future.delayed(Duration(seconds: 2)); // Simulate API delay
  }

  // Reset form
  void resetForm() {
    selectedIssueType.value = '';
    selectedIssue.value = '';
    issueDescription.value = '';
  }

  @override
  void onClose() {
    // Clean up resources if needed
    super.onClose();
  }
}
