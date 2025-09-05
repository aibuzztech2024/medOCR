import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/viewModels/auth/register/medical_provider/medical_provider_controller.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalProviderSecurity extends StatelessWidget {
  final VoidCallback onRegister;
  const MedicalProviderSecurity({super.key, required this.onRegister});

  @override
  Widget build(BuildContext context) {
    final MedicalProviderController medicalController = Get.put(
      MedicalProviderController(),
    );
    return Column(
      spacing: 16,
      children: [
        InputField(
          hintText: 'Username',
          controller: medicalController.usernameController,
        ),
        PasswordField(
          hintText: 'Password',
          controller: medicalController.passwordController,
        ),
        PasswordField(
          hintText: 'Confirm Password',
          controller: medicalController.confirmPasswordController,
        ),
        AppButton(
          type: ButtonType.filled,
          text: 'Register',
          width: double.infinity,
          onPressed: () {
  medicalController.registerMedicalProvider(onSuccess: onRegister);
          },
        ),
      ],
    );
  }
}
