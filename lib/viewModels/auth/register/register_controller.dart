import 'package:country_picker/country_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  // Email input controller
  var emailController = TextEditingController();

  // Selected country (default: India)
  var country = Country.parse('IN').obs;

  // Phone number input controller
  var phoneNumberController = TextEditingController();

  // OTP input controller
  var otpController = TextEditingController();

  // Tracks the current step in the registration process
  var activeStep = 0.obs;

  // Selected gender: 'M', 'F'
  var gender = ''.obs;

  // Checkbox for privacy policy acceptance
  var isPrivacyPolicyAccepted = false.obs;

  // Method to simulate sending OTP
  sendOtp() {
    Get.log(
      'Send otp to ${country.value.phoneCode + phoneNumberController.text}',
    );
  }

  // Method to simulate resending OTP
  resendOtp() {
    Get.log(
      'Resend otp to ${country.value.phoneCode + phoneNumberController.text}',
    );
  }
}
