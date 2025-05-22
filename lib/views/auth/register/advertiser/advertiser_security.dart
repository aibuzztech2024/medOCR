import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/password_field.dart';
import 'package:flutter/material.dart';

class AdvertiserSecurity extends StatelessWidget {
  final VoidCallback onRegister;
  const AdvertiserSecurity({super.key, required this.onRegister});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        InputField(
          hintText: 'Defaultemail@Gmail.com',
          controller: TextEditingController(),
        ),
        PasswordField(controller: TextEditingController()),
        PasswordField(
          controller: TextEditingController(),
          hintText: 'Confirm Password',
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
