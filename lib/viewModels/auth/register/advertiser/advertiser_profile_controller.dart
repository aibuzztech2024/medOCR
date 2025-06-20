import 'package:avatar/core/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:country_picker/country_picker.dart';
import 'dart:convert';
import 'dart:async'; // For TimeoutException
import 'dart:io'; // For SocketException

class AdvertiserController extends GetxController {
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

      // Create the request body with proper field mapping
      final Map<String, dynamic> requestBody = {
        'email': emailController.text.trim(),
        'phone-number1':
            '${country.value.phoneCode}${phoneNumberController.text.trim()}',
        'company-name': businessNameController.text.trim(),
        'advertiser-type': advertiserTypeController.text.trim(),
        'ad-service-required': adServicesController.text.trim(),
        'website-url': websiteUrlController.text.trim(),
        'address': addressController.text.trim(),
        'dist': cityController.text.trim(),
        'pincode': pincodeController.text.trim(),
        'state': stateController.text.trim(),
        'country': country.value.name, // Use selected country
        'latitude': "17.3850", // You might want to get actual location
        'longitude': "78.4867", // You might want to get actual location
        'incorporation-doc': incorporationController.text.trim(),
        'gst-number': gstController.text.trim(),
        'pan-number': panController.text.trim(),
        'tan-number': tanController.text.trim(),
        'brand-img': brandImageController.text.trim(),
        'brand-desc': descriptionController.text.trim(),
        'password': passwordController.text.trim(),
        'contact-name': "Anjali Verma", // TODO: Get from contact person form
        'contact-role':
            "Head of Operations", // TODO: Get from contact person form
        'phone-number2': "9009988776", // TODO: Get from contact person form
        'referral': referralCodeController.text.trim(),
      };

      print('Request URL: ${ApiConstants.advertiserRegisterEndpoint}');
      print('Request Body: ${json.encode(requestBody)}');

      final response = await http
          .post(
            Uri.parse(ApiConstants.advertiserRegisterEndpoint),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: json.encode(requestBody),
          )
          .timeout(const Duration(seconds: 30));

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        Get.snackbar('Success', 'Profile created successfully');
        return true;
      } else {
        // Parse error response if available
        try {
          final errorData = json.decode(response.body);
          Get.snackbar(
            'Error',
            errorData['message'] ?? 'Failed to create profile',
          );
        } catch (e) {
          Get.snackbar(
            'Error',
            'Failed to create profile. Status: ${response.statusCode}',
          );
        }
        return false;
      }
    } on SocketException catch (e) {
      print('SocketException: $e');
      Get.snackbar(
        'Error',
        'No internet connection. Please check your network.',
      );
      return false;
    } on TimeoutException catch (e) {
      print('TimeoutException: $e');
      Get.snackbar('Error', 'Request timed out. Please try again.');
      return false;
    } on FormatException catch (e) {
      print('FormatException: $e');
      Get.snackbar('Error', 'Invalid response format from server.');
      return false;
    } catch (e) {
      print('General Exception: $e');
      Get.snackbar('Error', 'Network error: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
