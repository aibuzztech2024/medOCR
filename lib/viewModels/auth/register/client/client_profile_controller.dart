import 'package:avatar/core/constants/api_constants.dart';
import 'package:avatar/models/auth/register/client_model.dart';
import 'package:avatar/viewModels/auth/register/contact_controller.dart';
import 'package:avatar/viewModels/auth/register/user/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ClientController extends GetxController {
  final RegisterController registerController = Get.find<RegisterController>();
  final ContactController contactController = Get.find<ContactController>();

  var incorporationController = TextEditingController();
  var gstController = TextEditingController();
  var panController = TextEditingController();
  var tanController = TextEditingController();
  var businessNameController = TextEditingController();
  var companyTypeController = TextEditingController();
  var servicesInterestedInController = TextEditingController();
  var websiteUrlController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var pincodeController = TextEditingController();
  var referralCodeController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  void uploadClientIncorporationNumber() {}

  void uploadClientGst() {}

  void uploadClientPan() {}

  void uploadClientTan() {}

  // Method to call medical provider register API
  Future<void> registerClient({required VoidCallback onSuccess}) async {
    final model = ClientRequestModel(
      email: emailController.text.trim(),
      phoneNumber1:
          registerController.country.value.phoneCode +
          registerController.phoneNumberController.text.trim(),
      companyName: businessNameController.text.trim(),
      servicesIntrested: servicesInterestedInController.text.trim(),
      websiteUrl: websiteUrlController.text.trim(),
      address: addressController.text.trim(),
      dist: cityController.text.trim(),
      pincode: pincodeController.text.trim(),
      state: stateController.text.trim(),
      country: registerController.country.value.name,
      latitude: '12.9716',
      longitude: '77.5946',
      incorporationDoc: incorporationController.text.trim(),
      gstNumber: gstController.text.trim(),
      panNumber: panController.text.trim(),
      tanNumber: tanController.text.trim(),
      password: passwordController.text.trim(),
      contactName: contactController.nameController.text.trim(),
      contactRole: contactController.designationController.text.trim(),
      phoneNumber2:
          contactController.selectedCountryCode.value +
          contactController.phoneController.text.trim(),
      referralCode: referralCodeController.text.trim(),
    );

    try {
      print('registerClient called');
      final response = await http.post(
        Uri.parse(ApiConstants.clientRegisterEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(model.toJson()),
      );

      Get.printInfo(info: 'Status Code: ${response.statusCode}');
      Get.printInfo(info: 'Response: ${response.body}');
      final data = jsonDecode(response.body);

      print('Status: ${response.statusCode}, Success: ${data['success']}');

      if (response.statusCode == 201 && data['success'] == true) {
        Get.snackbar('Success', data['message'] ?? 'Registered successfully');
      } else {
        Get.snackbar('Failed', data['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      Get.snackbar('Error', 'Unable to register. Check internet connection.');
    }
  }
}
