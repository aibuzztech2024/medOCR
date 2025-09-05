import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/height_box.dart';
import 'package:avatar/viewModels/auth/register/user/register_controller.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

/// A widget that displays user credential fields (username, password, confirm password)
/// as part of the registration process.
///
/// Includes a "Register" button that calls [onRegister] when pressed.
class UserSecurity extends StatelessWidget {
  /// Callback to be invoked when the user taps the Register button.
  final VoidCallback onRegister;

  const UserSecurity({super.key, required this.onRegister});

  @override
  Widget build(BuildContext context) {

      var registerController =
      Get.isRegistered<RegisterController>()
          ? Get.find<RegisterController>()
          : Get.put(RegisterController());
    return Column(
      children: [
        // Input field for the username
        InputField(
          hintText: 'Username',
          controller:
              registerController.usernameController, // Consider using persistent controller if needed
        ),
        HeightBox(16),

        // Input field for the password
        PasswordField(
          hintText: 'Password',
          controller: registerController.passwordController, // Can be obscured for better UX
        ),
        HeightBox(16),

        // Input field to confirm password
        PasswordField(
          hintText: 'Confirm Password',
          controller:
              registerController.confirmPasswordController, // Should match the password field
        ),
        HeightBox(16),

        // Register button that executes the callback
        AppButton(
          width: double.infinity,
          type: ButtonType.filled,
          onPressed: () {
            if (registerController.isPasswordMatching()) {
              onRegister();
            } else {
              Get.snackbar(
                'Password Mismatch',
                'Passwords do not match. Please try again.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red.shade100,
              );
            }
          }, // Triggers the registration logic
          text: 'Register',
        ),
      ],
    );
  }
}
