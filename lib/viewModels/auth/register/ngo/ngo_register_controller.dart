import 'package:avatar/models/auth/ngo/ngo_model.dart';
import 'package:avatar/services/auth/register/ngo/ngo_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NgoRegisterController extends GetxController {
  // 🔹 Step 1: Basic Info
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final otpController = TextEditingController(); // if you're using OTP
  final countryCode = "+91".obs; // for example

  // 🔹 Step 2: NGO Details
  final ngoNameController = TextEditingController();
  final websiteUrlController = TextEditingController();
  final ngoServicesController = TextEditingController();
  final addressController = TextEditingController();
  final distController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final countryController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final referralController = TextEditingController();

  // 🔹Step 3: Contact Person
  final contactNameController = TextEditingController();
  final contactRoleController = TextEditingController();
  final phoneNumber2Controller = TextEditingController();
  final contactotpController = TextEditingController();

  // 🔹 Step 4: Document Info
  final ngoRegistrationDocController =
      TextEditingController(); // string or filename
  final gstNumberController = TextEditingController();
  final panNumberController = TextEditingController();
  final tanNumberController = TextEditingController();
  final doc12AController = TextEditingController();
  final section8DocController = TextEditingController();
  final brandImgController = TextEditingController(); // URL or file name
  final brandDescController = TextEditingController();

  // 🔹 Step 4: Brand & Security
  final emailController1 = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void onClose() {
    // Dispose all controllers
    emailController.dispose();
    emailController1.dispose();
    phoneNumberController.dispose();
    otpController.dispose();
    ngoNameController.dispose();
    websiteUrlController.dispose();
    ngoServicesController.dispose();
    addressController.dispose();
    distController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    countryController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    ngoRegistrationDocController.dispose();
    gstNumberController.dispose();
    panNumberController.dispose();
    tanNumberController.dispose();
    doc12AController.dispose();
    section8DocController.dispose();
    brandImgController.dispose();
    brandDescController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    contactNameController.dispose();
    contactRoleController.dispose();
    phoneNumber2Controller.dispose();
    referralController.dispose();
    super.onClose();
  }

  void uploadRegistrationDoc() {}
  void uploadNgoGst() {}
  void uploadNgoPan() {}
  void uploadNgoTan() {}
  void uploadNgo12ADoc() {}
  void uploadNgoSection8Doc() {}
  void uploadNgoBrandimg() {}
  void uploadNgoBrandDesc() {}

  //for Ngo Register
  Future<void> registerNgo() async {
    // Create the model from controller data
    final ngoModel = NgoProfileModel(
      email: emailController1.text,
      phoneNumber1: phoneNumberController.text,
      ngoName: ngoNameController.text,
      websiteUrl: websiteUrlController.text,
      ngoServices: ngoServicesController.text,
      address: addressController.text,
      dist: distController.text,
      state: stateController.text,
      pincode: pincodeController.text,
      country: countryController.text,
      latitude: "20.4625", // TODO :  need to use original data instead of dummy
      longitude:
          "85.8828", // TODO :  need to use original data instead of dummy
      ngoRegistrationDoc: ngoRegistrationDocController.text,
      gstNumber: gstNumberController.text,
      panNumber: panNumberController.text,
      tanNumber: tanNumberController.text,
      doc12A: doc12AController.text,
      section8Doc: section8DocController.text,
      brandImg: brandImgController.text,
      brandDesc: brandDescController.text,
      password: passwordController.text,
      contactName: contactNameController.text,
      contactRole: contactRoleController.text,
      phoneNumber2: phoneNumber2Controller.text,
      referral: referralController.text,
    );
    try {
      // Call the API via service
      final repo = NgoRepository();
      final success = await repo.registerNgo(ngoModel);

      if (success) {
        Get.snackbar("Success", "NGO Registered Successfully");
      } else {
        Get.printInfo(info: "error");
        Get.snackbar("Error", "Registration failed. Please try again");
      }
    } catch (e) {
      Get.printInfo(info: "error occured : $e");
    }
  }
}
