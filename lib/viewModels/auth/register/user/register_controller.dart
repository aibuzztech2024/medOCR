import 'package:avatar/core/widgets/snackbar.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;

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
  Future<void> sendOtp() async {
    if (!validateEmailAndPhone()) return;

    isLoading.value = true;
    try {
      Get.log(
        'Sending OTP to ${country.value.phoneCode + phoneNumberController.text}',
      );

      // Simulate API delay
      await Future.delayed(Duration(seconds: 2));

      Get.snackbar("OTP Sent", "OTP has been sent to your number.");
    } catch (e) {
      Get.snackbar("Error", "Failed to send OTP");
    } finally {
      isLoading.value = false;
    }
  }

  // Method to simulate resending OTP
  Future<void> resendOtp() async {
    if (!validateEmailAndPhone()) return;

    isLoading.value = true;
    try {
      Get.log(
        'Resending OTP to ${country.value.phoneCode + phoneNumberController.text}',
      );

      // Simulate API delay
      await Future.delayed(Duration(seconds: 2));

      Get.snackbar("OTP Resent", "OTP has been resent to your number.");
    } catch (e) {
      Get.snackbar("Error", "Failed to resend OTP");
    } finally {
      isLoading.value = false;
    }
  }

  bool validateEmailAndPhone() {
    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      AppSnackbar.showError(
        "Invalid Email",
        "Please enter a valid email address",
      );
      return false;
    }

    if (phoneNumberController.text.isEmpty ||
        phoneNumberController.text.length < 10) {
      AppSnackbar.showError(
        "Invalid Phone",
        "Please enter a valid phone number",
      );
      return false;
    }

    return true;
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
