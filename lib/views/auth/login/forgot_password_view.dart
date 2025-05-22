import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/core/widgets/height_box.dart';
import 'package:avatar/viewModels/auth/login/login_controller.dart';
import 'package:avatar/views/auth/widget/app_scaffold.dart';
import 'package:avatar/views/auth/widget/header_text.dart';
import 'package:avatar/views/auth/widget/hero_image.dart';
import 'package:avatar/views/auth/widget/password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A view for resetting the password.
/// It contains a header image, a header text, two password fields,
/// and a button to reset the password.
class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return AppScaffold(
      showBackButton: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Header image
            HeroImage(),
            // Header Text
            HeaderText(title: 'Forgot Password'),
            // New password field
            PasswordField(
              hintText: 'New Password',
              controller: loginController.newsPasswordController,
            ),
            // Alert info message
            AppText.caption(
              'New Password Can\'t Be Same As Old One',
              color: context.theme.hintColor,
            ),
            const SizedBox(height: 16),
            // Confirm password field
            PasswordField(
              hintText: 'Confirm Password',
              controller: loginController.confirmPasswordController,
            ),
            HeightBox(20),
            // Login Button
            AppButton(
              width: double.infinity,
              type: ButtonType.filled,
              text: 'Log-In',
              onPressed: loginController.resetPassword,
            ),
          ],
        ),
      ),
    );
  }
}
