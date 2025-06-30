import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/auth/register/contact_controller.dart';
import 'package:avatar/views/auth/widget/app_country_picker.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/input_with_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactPerson extends StatelessWidget {
  final VoidCallback onContinue;
  const ContactPerson({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputField(
          hintText: 'Name',
          controller: controller.nameController,
        ),
        const SizedBox(height: 16),
        InputField(
          hintText: 'Designation',
          controller: controller.designationController,
        ),
        const SizedBox(height: 16),

        InputWithAction(
          expandedFirst: false,
          expandedChild: InputField(
            hintText: 'Enter Phone No',
            controller: controller.phoneController,
          ),
          trailingChild: AppCountryPicker(
            onSelect: (val) {
              controller.selectedCountryCode.value = val as String;
            },
          ),
        ),

        const SizedBox(height: 16),
        Obx(() => AppButton(
              type: ButtonType.filled,
              text: controller.isOtpSent.value ? 'OTP Sent' : 'Send OTP',
              width: double.infinity,
              onPressed: () {
                // Implement your OTP logic here
                controller.isOtpSent.value = true;
              },
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Opacity(
              opacity: .7,
              child: AppText.caption('Didn\'t Receive Code ? '),
            ),
            AppButton(
              type: ButtonType.text,
              child: AppText.body('Resend', color: context.theme.primaryColor),
              onPressed: () {
                // Resend OTP logic
                controller.isOtpSent.value = true;
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        InputField(
          hintText: 'Enter OTP',
          controller: controller.otpController,
        ),
        Opacity(
          opacity: .7,
          child: AppText.caption(
            'You\'ll Receive A 6 Digit Code On Your Phone',
          ),
        ),
        const SizedBox(height: 16),
        AppButton(
          type: ButtonType.filled,
          text: 'Continue',
          width: double.infinity,
          onPressed: onContinue,
        ),
      ],
    );
  }
}
