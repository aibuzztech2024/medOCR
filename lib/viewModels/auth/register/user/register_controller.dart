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

  // name, address, city, state, pincode, and referral code controllers
  final nameController = TextEditingController();

  final dobController = TextEditingController();

  final addressController = TextEditingController();

  final cityController = TextEditingController();

  final stateController = TextEditingController();

  final pincodeController = TextEditingController();

  final referralCodeController = TextEditingController();

  final selfieController = TextEditingController();

  var isPrivacyPolicyAccepted = false;

  // Username, password, and confirm password controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

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

  bool isPasswordMatching() {
    return passwordController.text == confirmPasswordController.text;
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    referralCodeController.dispose();
    super.dispose();
  }
}
