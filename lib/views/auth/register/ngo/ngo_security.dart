import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/password_field.dart';
import 'package:flutter/material.dart';

class NgoSecurity extends StatelessWidget {
  final VoidCallback onRegister;
  const NgoSecurity({super.key, required this.onRegister});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        InputField(
          hintText: 'Defaultemail@gmail.com',
          controller: TextEditingController(),
        ),
        PasswordField(controller: TextEditingController()),
        PasswordField(
          hintText: 'Confirm Password',
          controller: TextEditingController(),
        ),
        AppButton(
          type: ButtonType.filled,
          text: 'Register',
          width: double.infinity,
          onPressed: onRegister,
        ),
      ],
    );
  }
}
