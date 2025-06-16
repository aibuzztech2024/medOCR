import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/viewModels/auth/register/ngo/ngo_security_controller.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NgoSecurity extends StatelessWidget {
  final VoidCallback onRegister;
  const NgoSecurity({super.key, required this.onRegister});

  @override
  Widget build(BuildContext context) {
    final NgoSecurityController ngoSecurityController = Get.put(
      NgoSecurityController(),
    );
    return Column(
      spacing: 16,
      children: [
        InputField(
          hintText: 'Defaultemail@gmail.com',
          controller: ngoSecurityController.emailController,
        ),
        PasswordField(controller: ngoSecurityController.passwordController),
        PasswordField(
          hintText: 'Confirm Password',
          controller: ngoSecurityController.confirmPasswordController,
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
