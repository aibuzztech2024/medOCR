import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/core/widgets/height_box.dart';
import 'package:avatar/viewModels/auth/register/ngo/ngo_register_controller.dart';
import 'package:avatar/viewModels/auth/register/register_controller.dart';
import 'package:avatar/viewModels/auth/register/user/register_controller.dart';
import 'package:avatar/views/auth/widget/app_country_picker.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/input_with_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicInfo extends StatelessWidget {
  /// On continue proceed to desired step
  final VoidCallback onContinue;
  const BasicInfo({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    // Check if this controller is already present in memory,
    // if so, then find it else put it
    final registerController =
        Get.isRegistered<RegisterController>()
            ? Get.find<RegisterController>()
            : Get.put(RegisterController());
    return Column(
      children: [
        // Email field
        InputField(
          hintText: 'Email',
          controller: registerController.emailController,
        ),
        HeightBox(16),
        // Country Picker and Mobile Number field
        InputWithAction(
          expandedFirst: false,
          expandedChild: InputField(
            hintText: 'Enter Phone No',
            controller: registerController.phoneNumberController,
          ),
          trailingChild: AppCountryPicker(
            onSelect: (val) {
              // Updates country code
              registerController.country.value = val;
            },
          ),
        ),
        HeightBox(16),
        // Send otp button
        AppButton(
          width: double.infinity,
          type: ButtonType.filled,
          text: 'Send OTP',
          onPressed: () {
            final isValid = registerController.validateEmailAndPhone();
            if (isValid) {
              registerController.sendOtp();
            }
          },
        ),
        // Resend otp
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Resend otp info
            AppText.caption('Didn\'t Receive Code? '),
            // Resend otp button
            AppButton(
              type: ButtonType.text,
              onPressed: registerController.resendOtp,
              child: AppText.caption(
                'Resend',
                color: context.theme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        HeightBox(16),
        // OTP field
        InputField(
          hintText: 'Enter OTP',
          controller: registerController.otpController,
        ),
        HeightBox(16),
        // Continue to next step button
        AppButton(
          width: double.infinity,
          type: ButtonType.filled,
          text: 'Continue',
          onPressed: () {
            onContinue();
            final ngoController = Get.find<NgoRegisterController>();
            ngoController.phoneNumberController.text =
                registerController.phoneNumberController.text;
          },
        ),
        HeightBox(16),
      ],
    );
  }
}
