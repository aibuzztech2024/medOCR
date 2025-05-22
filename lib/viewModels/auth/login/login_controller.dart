import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/// A controller that manages login and password reset logic for a login screen.
///
/// This controller holds `TextEditingController`s for handling input values
class LoginController extends GetxController {
  /// Controller for the username or email input field.
  var usernameController = TextEditingController();

  /// Controller for the password input field.
  var passwordController = TextEditingController();

  /// Controller for the new password input (used in reset password).
  var newsPasswordController = TextEditingController();

  /// Controller for confirming the new password (used in reset password).
  var confirmPasswordController = TextEditingController();

  // WARN: Currently only prints info.
  // TODO: Implement actual login functionality
  void login() {
    Get.printInfo(info: usernameController.text);
    Get.printInfo(info: passwordController.text);
  }

  // WARN: Currently only prints info.
  // TODO: Implement actual login functionality
  void resetPassword() {
    Get.printInfo(info: newsPasswordController.text);
    Get.printInfo(info: confirmPasswordController.text);
  }
}
