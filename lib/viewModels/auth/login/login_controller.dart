// lib/controllers/login_controller.dart
import 'dart:convert';
import 'package:avatar/core/constants/api_constants.dart';
import 'package:avatar/core/utils/methods/navigate_to.dart';
import 'package:avatar/models/auth/login/user_model.dart';
import 'package:avatar/widgets/bottom_navbar_end_customer.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
  // WARN: Currently only prints info.
  // TODO: Implement actual login functionality
  void login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    Get.printInfo(info: 'Username: $username');
    Get.printInfo(info: 'Password: $password');

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Login Error', 'Username and password cannot be empty');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(ApiConstants.loginEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user-name': username, 'Password': password}),
      );

      Get.printInfo(info: 'Status Code: ${response.statusCode}');
      Get.printInfo(info: 'Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          final user = UserModel.fromJson(data['user']);
          Get.printInfo(info: 'Login successful: ${user.name}');
          Get.snackbar('Login successful', 'Welcome, ${user.name}!');
          navigateTo(() => const BottomNavbarEndCustomer());
          // TODO: Navigate to next screen or store user
        } else {
          Get.snackbar(
            'Login Failed',
            data['message'] ?? 'Invalid credentials provided',
          );
        }
      } else if (response.statusCode == 400) {
        Get.snackbar(
          'Login Failed',
          'Missing required fields or invalid format',
        );
      } else if (response.statusCode == 401) {
        Get.snackbar(
          'Login Failed',
          'Unauthorized: Incorrect username or password',
        );
      } else if (response.statusCode == 500) {
        Get.snackbar(
          'Server Error',
          'Something went wrong on our end. Please try again later.',
        );
      } else {
        Get.snackbar(
          'Login Failed',
          'Unexpected error occurred. Please try again.',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Network Error',
        'Unable to connect to the server. Please check your internet connection.',
      );
    }
  }

  // WARN: Currently only prints info.
  // TODO: Implement actual login functionality
  void resetPassword() {
    Get.printInfo(info: newsPasswordController.text);
    Get.printInfo(info: confirmPasswordController.text);
  }
}
