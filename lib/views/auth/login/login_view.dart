import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/core/widgets/height_box.dart';
import 'package:avatar/core/utils/methods/navigate_to.dart';
import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/divider_with_text.dart';
import 'package:avatar/viewModels/auth/login/login_controller.dart';
import 'package:avatar/views/auth/login/forgot_password_view.dart';
import 'package:avatar/views/auth/select_role_view.dart';
import 'package:avatar/views/auth/widget/app_scaffold.dart';
import 'package:avatar/views/auth/widget/header_text.dart';
import 'package:avatar/views/auth/widget/hero_image.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This is [LoginScreen]
///
/// This view includes:
/// - A header image and title
/// - Username and password input fields
/// - Login button
/// - Navigation options for Forgot Password and Register
/// - Divider with "Or" for alternate navigation
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject the LoginController using GetX
    final LoginController loginController = Get.put(LoginController());

    return AppScaffold(
      showBackButton: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              /// Displays the top image (e.g., avatar or illustration)
              HeroImage(),

              /// Displays the header title "Log-In"
              HeaderText(title: 'Log-In'),

              /// Username input field bound to the controller
              InputField(
                hintText: 'Username',
                controller: loginController.usernameController,
              ),

              HeightBox(16),

              /// Password input field with visibility toggle
              PasswordField(controller: loginController.passwordController),

              /// "Forgot Password?" button aligned to the right
              Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  type: ButtonType.text,
                  child: AppText.body(
                    'Forgot Password?',
                    color: context.theme.primaryColor,
                  ),
                  onPressed: () => navigateTo(() => ForgotPasswordView()),
                ),
              ),

              HeightBox(16),

              /// Login button that triggers the login logic
              AppButton(
                width: double.infinity,
                type: ButtonType.filled,
                text: 'Log-In',
                onPressed: loginController.login,
              ),

              HeightBox(16),

              /// Visual separator with "Or"
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: DividerWithText('Or'),
              ),

              HeightBox(16),

              /// Register button that navigates to RegisterView
              AppButton(
                width: double.infinity,
                type: ButtonType.outlined,
                text: 'Register',
                onPressed: () => navigateTo(() => SelectRoleView()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
