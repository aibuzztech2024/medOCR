import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/viewModels/auth/register/advertiser/advertiser_security_controller.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AdvertiserSecurity extends StatelessWidget {
  final VoidCallback onRegister;
  const AdvertiserSecurity({super.key, required this.onRegister});

  @override
  Widget build(BuildContext context) {
    final AdvertiserSecurityController advertiserSecurityController = Get.put(
      AdvertiserSecurityController(),
    );
    return Column(
      spacing: 16,
      children: [
        InputField(
          hintText: 'Defaultemail@Gmail.com',
          controller: advertiserSecurityController.emailController,
        ),
        PasswordField(
          controller: advertiserSecurityController.passwordController,
        ),
        PasswordField(
          controller: advertiserSecurityController.confirmPasswordController,
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
