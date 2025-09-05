import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/viewModels/auth/register/client/client_profile_controller.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientSecurity extends StatelessWidget {
  final VoidCallback onRegister;
  const ClientSecurity({super.key, required this.onRegister});

  @override
  Widget build(BuildContext context) {
    final ClientController clientSecurityController = Get.put(
      ClientController(),
    );
    return Column(
      spacing: 16,
      children: [
        InputField(
          hintText: 'Defaultemail@Gmail.com',
          controller: clientSecurityController.emailController,
        ),
        PasswordField(controller: clientSecurityController.passwordController),
        PasswordField(
          hintText: 'Confirm Password',
          controller: clientSecurityController.confirmPasswordController,
        ),
        AppButton(
          type: ButtonType.filled,
          text: 'Register',
          width: double.infinity,
          onPressed: () {
            clientSecurityController.registerClient(onSuccess: onRegister);
          },
        ),
      ],
    );
  }
}
