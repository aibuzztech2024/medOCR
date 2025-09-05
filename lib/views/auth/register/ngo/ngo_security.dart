import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/models/auth/ngo/ngo_model.dart';
import 'package:avatar/services/auth/register/ngo/ngo_service.dart';
import 'package:avatar/viewModels/auth/register/ngo/ngo_register_controller.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NgoSecurity extends StatelessWidget {
  final VoidCallback onRegister;
  const NgoSecurity({super.key, required this.onRegister});

  @override
  Widget build(BuildContext context) {
    final registerController = Get.find<NgoRegisterController>();

    return Column(
      spacing: 16,
      children: [
        InputField(
          hintText: 'Defaultemail@gmail.com',
          controller: registerController.emailController1,
        ),
        PasswordField(controller: registerController.passwordController),
        PasswordField(
          hintText: 'Confirm Password',
          controller: registerController.confirmPasswordController,
        ),
        AppButton(
          type: ButtonType.filled,
          text: 'Register',
          width: double.infinity,
          onPressed: () async {
            final controller = Get.find<NgoRegisterController>();

            if (controller.passwordController.text !=
                controller.confirmPasswordController.text) {
              Get.snackbar("Error", "Passwords do not match");
              return;
            }

            controller.registerNgo();
          },
        ),
      ],
    );
  }
}
