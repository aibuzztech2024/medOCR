import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NgoController extends GetxController {
  /// NGO Name input controller
  final ngoNameController = TextEditingController();

  /// NGO Service input controller
  final ngoServiceController = TextEditingController();

  /// Website URL input controller
  final websiteUrlController = TextEditingController();

  /// Address input controller
  final addressController = TextEditingController();

  /// City/Town/District input controller
  final cityController = TextEditingController();

  /// State input controller
  final stateController = TextEditingController();

  /// Pincode input controller
  final pincodeController = TextEditingController();

  /// Referral Code input controller
  final referralCodeController = TextEditingController();

  /// Checkbox for policy agreement
  final isPolicyAccepted = false.obs;

  // NGO Registration
  final ngoRegController = TextEditingController();

  // GST
  final gstController = TextEditingController();

  // PAN
  final panController = TextEditingController();

  // TAN
  final tanController = TextEditingController();

  // 12A
  final doc12AController = TextEditingController();

  // Section 8
  final section8Controller = TextEditingController();

  // NGO Image
  final ngoImageController = TextEditingController();

  // NGO Description
  final descriptionController = TextEditingController();

  /// Controllers for email and passwords
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    ngoRegController.dispose();
    gstController.dispose();
    panController.dispose();
    tanController.dispose();
    doc12AController.dispose();
    section8Controller.dispose();
    ngoImageController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
