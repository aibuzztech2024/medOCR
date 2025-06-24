import 'package:avatar/core/constants/api_constants.dart';
import 'package:avatar/models/auth/register/advertiser_model.dart';
import 'package:avatar/viewModels/auth/register/contact_controller.dart';
import 'package:avatar/viewModels/auth/register/user/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:country_picker/country_picker.dart';
import 'dart:convert';
import 'dart:async'; // For TimeoutException
import 'dart:io'; // For SocketException

class AdvertiserController extends GetxController {
  // Get references to other controllers
  late final RegisterController registerController;
  late final ContactController contactController;

  // Basic Info Controllers
  final emailController = TextEditingController();
  var country = Country.parse('IN').obs;
  final phoneNumberController = TextEditingController();
  final otpController = TextEditingController();
  var activeStep = 0.obs;
  var gender = ''.obs;
  var isPrivacyPolicyAccepted = false.obs;

  // Security Controllers
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Profile Controllers
  final businessNameController = TextEditingController();
  final advertiserTypeController = TextEditingController();
  final adServicesController = TextEditingController();
  final websiteUrlController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final referralCodeController = TextEditingController();

  // Document Controllers
  final incorporationController = TextEditingController();
  final gstController = TextEditingController();
  final panController = TextEditingController();
  final tanController = TextEditingController();
  final brandImageController = TextEditingController();
  final descriptionController = TextEditingController();

  // Loading state
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize controller references
    registerController = Get.put(RegisterController());
    contactController = Get.put(ContactController());
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneNumberController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    businessNameController.dispose();
    advertiserTypeController.dispose();
    adServicesController.dispose();
    websiteUrlController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    referralCodeController.dispose();
    incorporationController.dispose();
    gstController.dispose();
    panController.dispose();
    tanController.dispose();
    brandImageController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  // OTP methods
  sendOtp() {
    Get.log(
      'Send otp to ${country.value.phoneCode + phoneNumberController.text}',
    );
  }

  resendOtp() {
    Get.log(
      'Resend otp to ${country.value.phoneCode + phoneNumberController.text}',
    );
  }

  // File upload methods
  void uploadAdvertiserIncorporationNumber() {}
  void uploadAdvertiserGst() {}
  void uploadAdvertiserPan() {}
  void uploadAdvertiserTan() {}
  void uploadAdvertiserBrandImage() {}

  // Fixed API Integration
  Future<bool> submitAdvertiserData() async {
    isLoading.value = true;
    try {
      // Validate required fields first
      if (emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          businessNameController.text.isEmpty) {
        Get.snackbar('Error', 'Please fill in all required fields');
        return false;
      }

      // Call the register method
      await registerAdvertiser(
        onSuccess: () {
          Get.snackbar('Success', 'Advertiser registered successfully');
        },
      );

      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit advertiser data: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Method to call advertiser register API
  Future<void> registerAdvertiser({required VoidCallback onSuccess}) async {
    final model = AdvertiserModel(
      email: emailController.text.trim(),
      phoneNumber1: country.value.phoneCode + phoneNumberController.text.trim(),
      companyName: businessNameController.text.trim(),
      advertiserType: advertiserTypeController.text.trim(),
      adServiceRequired: adServicesController.text.trim(),
      websiteUrl: websiteUrlController.text.trim(),
      address: addressController.text.trim(),
      dist: cityController.text.trim(),
      pincode: pincodeController.text.trim(),
      state: stateController.text.trim(),
      country: country.value.name,
      latitude: '12.9716',
      longitude: '77.5946',
      incorporationDoc: incorporationController.text.trim(),
      gstNumber: gstController.text.trim(),
      panNumber: panController.text.trim(),
      tanNumber: tanController.text.trim(),
      brandImg: brandImageController.text.trim(),
      brandDesc: descriptionController.text.trim(),
      password: passwordController.text.trim(),
      contactName: contactController.nameController.text.trim(),
      contactRole: contactController.designationController.text.trim(),
      phoneNumber2:
          contactController.selectedCountryCode.value +
          contactController.phoneController.text.trim(),
      referral: referralCodeController.text.trim(),
    );

    try {
      final response = await http
          .post(
            Uri.parse(ApiConstants.advertiserRegisterEndpoint),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(model.toJson()),
          )
          .timeout(const Duration(seconds: 30));

      Get.printInfo(info: 'Status Code: ${response.statusCode}');
      Get.printInfo(info: 'Response: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        Get.snackbar('Success', data['message'] ?? 'Registered successfully');
        onSuccess();
      } else {
        Get.snackbar('Failed', data['message'] ?? 'Something went wrong');
      }
    } on TimeoutException {
      Get.snackbar('Error', 'Request timeout. Please try again.');
    } on SocketException {
      Get.snackbar(
        'Error',
        'No internet connection. Please check your network.',
      );
    } catch (e) {
      Get.snackbar('Error', 'Unable to register. Please try again later.');
      Get.printError(info: 'Registration error: $e');
    }
  }
}
