import 'package:avatar/views/enduser_phone_settings/user_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';

/// ViewModel (Controller) for managing edit details screen state and business logic
/// This class handles all user interactions, form validation, and data management
/// following the MVVM pattern with GetX for reactive state management
class EditAccountInformationController extends GetxController {
  // =========================================================================
  // TEXT EDITING CONTROLLERS - Managed by ViewModel
  // =========================================================================

  /// Text editing controllers for form input fields
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController dobController;
  late final TextEditingController addressController;
  late final TextEditingController pincodeController;

  // =========================================================================
  // REACTIVE STATE VARIABLES - Observable by View
  // =========================================================================

  /// Current user details model - reactive to UI changes
  final Rx<UserDetailsModel> _userDetails = UserDetailsModel().obs;
  UserDetailsModel get userDetails => _userDetails.value;

  /// Individual reactive variables for dropdown selections
  final RxnString _selectedGender = RxnString();
  final RxnString _selectedCountry = RxnString();
  final RxnString _selectedState = RxnString();
  final RxnString _selectedCity = RxnString();

  /// Public getters for dropdown selections
  String? get selectedGender => _selectedGender.value;
  String? get selectedCountry => _selectedCountry.value;
  String? get selectedState => _selectedState.value;
  String? get selectedCity => _selectedCity.value;

  /// Loading state for async operations
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// Form validation state
  final RxBool _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;

  // =========================================================================
  // LIFECYCLE METHODS - Controller Initialization and Cleanup
  // =========================================================================

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    _setupTextControllerListeners();
    _loadInitialData();
  }

  @override
  void onClose() {
    _disposeControllers();
    super.onClose();
  }

  // =========================================================================
  // INITIALIZATION METHODS - Setup Controllers and Data
  // =========================================================================

  /// Initialize all text editing controllers
  void _initializeControllers() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    dobController = TextEditingController();
    addressController = TextEditingController();
    pincodeController = TextEditingController();
  }

  /// Setup listeners for text controllers to update reactive model
  void _setupTextControllerListeners() {
    // Listen to text changes and update the model automatically
    nameController.addListener(_updateUserDetailsFromControllers);
    emailController.addListener(_updateUserDetailsFromControllers);
    phoneController.addListener(_updateUserDetailsFromControllers);
    dobController.addListener(_updateUserDetailsFromControllers);
    addressController.addListener(_updateUserDetailsFromControllers);
    pincodeController.addListener(_updateUserDetailsFromControllers);
  }

  /// Load initial data into controllers (placeholder values from original code)
  void _loadInitialData() {
    // Setting initial placeholder data as per original implementation
    nameController.text = 'Guarav';
    emailController.text = 'guarav@gmail.com';
    pincodeController.text = '22317';

    // Update the reactive model with initial data
    _updateUserDetailsFromControllers();
  }

  /// Dispose text editing controllers to prevent memory leaks
  void _disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    addressController.dispose();
    pincodeController.dispose();
  }

  // =========================================================================
  // DROPDOWN SELECTION METHODS - Handle User Input
  // =========================================================================

  /// Update gender selection and trigger reactive updates
  void updateGender(String? gender) {
    _selectedGender.value = gender;
    _updateUserDetailsModel();
  }

  /// Update country selection and reset dependent fields
  void updateCountry(String? country) {
    _selectedCountry.value = country;
    // Reset state and city when country changes (business logic)
    if (country != 'India') {
      _selectedState.value = null;
      _selectedCity.value = null;
    }
    _updateUserDetailsModel();
  }

  /// Update state selection and reset city
  void updateState(String? state) {
    _selectedState.value = state;
    // Reset city when state changes (business logic)
    _selectedCity.value = null;
    _updateUserDetailsModel();
  }

  /// Update city selection
  void updateCity(String? city) {
    _selectedCity.value = city;
    _updateUserDetailsModel();
  }

  // =========================================================================
  // PHONE NUMBER HANDLING - Country Code Selection
  // =========================================================================

  /// Handle country code selection from country picker widget
  void onCountryCodeSelected(Country country) {
    // Now you can use country.phoneCode, country.countryCode, etc.
    print('Selected country code: \\${country.phoneCode}');
  }

  // =========================================================================
  // DATA UPDATE AND VALIDATION - Model Management
  // =========================================================================

  /// Update user details model from text controllers
  void _updateUserDetailsFromControllers() {
    _userDetails.value = _userDetails.value.copyWith(
      name: nameController.text,
      email: emailController.text,
      phoneNumber: phoneController.text,
      dateOfBirth: dobController.text,
      address: addressController.text,
      pincode: pincodeController.text,
    );
    _validateForm();
  }

  /// Update user details model with dropdown selections
  void _updateUserDetailsModel() {
    _userDetails.value = _userDetails.value.copyWith(
      gender: _selectedGender.value,
      country: _selectedCountry.value,
      state: _selectedState.value,
      city: _selectedCity.value,
    );
    _validateForm();
  }

  /// Validate form completeness using model validation
  void _validateForm() {
    _isFormValid.value = _userDetails.value.isValid;
  }

  // =========================================================================
  // SAVE AND CANCEL OPERATIONS - Business Logic
  // =========================================================================

  /// Handle save changes operation with validation and error handling
  Future<void> saveChanges() async {
    // Validate form before proceeding
    if (!_isFormValid.value) {
      Get.snackbar(
        'Validation Error',
        'Please fill all required fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
      return;
    }

    try {
      _isLoading.value = true;

      // Simulate save operation (replace with actual API call)
      await _simulateSaveOperation();

      // Show success message
      Get.snackbar(
        'Success',
        'Changes saved successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade800,
      );

      // Navigate back after successful save
      Get.back();
    } catch (e) {
      // Handle save error
      Get.snackbar(
        'Error',
        'Failed to save changes: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  /// Handle cancel operation
  void cancelChanges() {
    // TODO: Add unsaved changes check if needed
    Get.back();
  }

  /// Simulate save operation (replace with actual implementation)
  Future<void> _simulateSaveOperation() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // In real implementation, this would:
    // 1. Send data to API endpoint
    // 2. Handle server validation
    // 3. Update local storage/cache
    // 4. Handle network errors

    print('Saving user details: ${_userDetails.value.toString()}');
  }

  // =========================================================================
  // RESPONSIVE UI HELPERS - View Support Methods
  // =========================================================================

  /// Calculate content width based on screen size for responsive design
  double getContentWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 900) return screenWidth * 0.6; // Desktop: 60% width
    if (screenWidth > 600) return screenWidth * 0.8; // Tablet: 80% width
    return screenWidth; // Mobile: Full width
  }

  /// Calculate top spacing based on screen height
  double getTopSpacing(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return (screenHeight * 0.04).clamp(30.0, 50.0);
  }

  /// Calculate vertical spacing between form elements
  double getVerticalSpacing(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return (screenHeight * 0.025).clamp(20.0, 30.0);
  }
}
