import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/auth/register/ngo/ngo_register_controller.dart';
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
     final registerController = Get.find<NgoRegisterController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputField(hintText: 'Name', controller: registerController.contactNameController),
        const SizedBox(height: 16),
        InputField(
          hintText: 'Designation',
          controller: registerController.contactRoleController,
        ),
        const SizedBox(height: 16),
        InputWithAction(
          expandedFirst: false,
          expandedChild: InputField(
            hintText: 'Enter Phone No',
            controller: registerController.phoneNumber2Controller,
          ),
          trailingChild: AppCountryPicker(onSelect: (val) {}),
        ),

        const SizedBox(height: 16),
        AppButton(
          type: ButtonType.filled,
          text: 'Send OTP',
          width: double.infinity,
          onPressed: () {},
        ),
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
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        InputField(hintText: 'Enter OTP', controller: registerController.contactotpController),
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
