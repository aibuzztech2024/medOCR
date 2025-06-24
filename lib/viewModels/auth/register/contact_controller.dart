import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  //name, designation, phone, and OTP input controllers
  final nameController = TextEditingController();

  final designationController = TextEditingController();

  final phoneController = TextEditingController();

  final otpController = TextEditingController();

  final selectedCountryCode = '+91'.obs; // default country code

  final isOtpSent = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    designationController.dispose();
    phoneController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
