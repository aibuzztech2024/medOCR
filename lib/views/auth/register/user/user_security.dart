import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/height_box.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/password_field.dart';
import 'package:flutter/material.dart';

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
    return Column(
      children: [
        // Input field for the username
        InputField(
          hintText: 'Username',
          controller:
              TextEditingController(), // Consider using persistent controller if needed
        ),
        HeightBox(16),

        // Input field for the password
        PasswordField(
          hintText: 'Password',
          controller: TextEditingController(), // Can be obscured for better UX
        ),
        HeightBox(16),

        // Input field to confirm password
        PasswordField(
          hintText: 'Confirm Password',
          controller:
              TextEditingController(), // Should match the password field
        ),
        HeightBox(16),

        // Register button that executes the callback
        AppButton(
          width: double.infinity,
          type: ButtonType.filled,
          onPressed: onRegister, // Triggers the registration logic
          text: 'Register',
        ),
      ],
    );
  }
}
