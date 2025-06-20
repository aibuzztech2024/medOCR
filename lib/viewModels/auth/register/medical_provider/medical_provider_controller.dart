import 'dart:convert';
import 'package:avatar/models/auth/register/medical_provider_model.dart';
import 'package:avatar/viewModels/auth/register/contact_controller.dart';
import 'package:avatar/viewModels/auth/register/user/register_controller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:avatar/core/constants/api_constants.dart';

class MedicalProviderController extends GetxController {
  final RegisterController registerController = Get.find<RegisterController>();

  final ContactController contactController = Get.find<ContactController>();

  // Text controllers for profile
  var incorporationController = TextEditingController();
  var gstController = TextEditingController();
  var panController = TextEditingController();
  var tanController = TextEditingController();
  var medicalLicenseNumberController = TextEditingController();
  var bankAccountNumberController = TextEditingController();

  // text controllers for security
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  //text controllers for documents
  var businessNameController = TextEditingController();
  var medicalProviderTypeController = TextEditingController();
  var servicesController = TextEditingController();
  var timingController = TextEditingController();
  var websiteUrlController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  // Selected country (default: India)
  var country = Country.parse('IN').obs;
  var pincodeController = TextEditingController();
  var referralCodeController = TextEditingController();

  void uploadMedicalIncorporationNumber() {}
  void uploadMedicalGst() {}
  void uploadMedicalPan() {}
  void uploadMedicalTan() {}
  void uploadMedicalLicenseNumber() {}
  void uploadMedicalAccountNumber() {}
  void uploadStoreFrontImage() {}

  // Method to call medical provider register API
  Future<void> registerMedicalProvider({
    required VoidCallback onSuccess,
  }) async {
    final model = MedicalProviderRequestModel(
      email: usernameController.text.trim(),
      phoneNumber1:
          registerController.country.value.phoneCode +
          registerController.phoneNumberController.text.trim(),
      companyName: businessNameController.text.trim(),
      typeOfProvider: medicalProviderTypeController.text.trim(),
      servicesYouOffer: servicesController.text.trim(),
      websiteUrl: websiteUrlController.text.trim(),
      workingHrs: timingController.text.trim(),
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
      medicalLicenseNumber: medicalLicenseNumberController.text.trim(),
      password: passwordController.text.trim(),
      contactName:
          contactController.nameController.text
              .trim(),
      contactRole:
          contactController.designationController.text
              .trim(), 
      phoneNumber2:
          contactController.selectedCountryCode.value +
          contactController.phoneController.text.trim(),
      referralCode: referralCodeController.text.trim(),
    );

    try {
      final response = await http.post(
        Uri.parse(ApiConstants.medicalProviderEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(model.toJson()),
      );

      Get.printInfo(info: 'Status Code: ${response.statusCode}');
      Get.printInfo(info: 'Response: ${response.body}');
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        Get.snackbar('Success', data['message'] ?? 'Registered successfully');
      } else {
        Get.snackbar('Failed', data['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      Get.snackbar('Error', 'Unable to register. Check internet connection.');
    }
  }
}
