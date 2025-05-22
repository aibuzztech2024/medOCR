import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/views/auth/widget/app_country_picker.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/input_with_action.dart';
import 'package:avatar/views/auth/widget/policy_checkbox.dart';
import 'package:flutter/material.dart';

class ClientProfile extends StatelessWidget {
  final VoidCallback onContinue;
  const ClientProfile({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        InputField(
          hintText: 'Business Name',
          controller: TextEditingController(),
        ),
        InputField(
          hintText: 'Company Type',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: TextEditingController(),
        ),
        InputField(
          hintText: 'Services Your Interested In',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: TextEditingController(),
        ),
        InputField(
          hintText: 'Website URL',
          controller: TextEditingController(),
        ),
        InputField(hintText: 'Address', controller: TextEditingController()),
        InputField(
          hintText: 'City/Town/District',
          controller: TextEditingController(),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'State',
            controller: TextEditingController(),
          ),
          trailingChild: AppCountryPicker(onSelect: (val) {}),
        ),
        InputField(hintText: 'Pincode', controller: TextEditingController()),
        InputField(
          hintText: 'Referral Code',
          controller: TextEditingController(),
        ),
        PolicyCheckbox(onChange: (val) {}),
        AppButton(
          type: ButtonType.filled,
          text: 'Continue',
          width: double.infinity,
          onPressed: onContinue,
        ),
        SizedBox(),
      ],
    );
  }
}
