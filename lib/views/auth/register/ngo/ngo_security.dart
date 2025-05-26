import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/viewModels/auth/register/ngo/ngo_controller.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NgoSecurity extends StatelessWidget {
  final VoidCallback onRegister;
  const NgoSecurity({super.key, required this.onRegister});

  @override
  Widget build(BuildContext context) {
    // Register or retrieve existing controller
        final controller =
        Get.isRegistered<NgoController>()
            ? Get.find<NgoController>()
            : Get.put(NgoController());

    return Column(
      spacing: 16,
      children: [
        // Email input field
        InputField(
          hintText: 'Defaultemail@gmail.com',
          controller: controller.emailController,
        ),

        // Password field
        PasswordField(controller: controller.passwordController),

        // Confirm password field
        PasswordField(
          hintText: 'Confirm Password',
          controller: controller.confirmPasswordController,
        ),

        // Register button
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
