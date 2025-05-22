import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/width_box.dart';
import 'package:avatar/views/auth/widget/app_country_picker.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/policy_checkbox.dart';
import 'package:flutter/material.dart';

class MedicalProviderProfile extends StatelessWidget {
  final VoidCallback onContinue;
  const MedicalProviderProfile({super.key, required this.onContinue});

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
          hintText: 'Type Of Medical Provider',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: TextEditingController(),
        ),

        InputField(
          hintText: 'Services You Offer',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: TextEditingController(),
        ),
        InputField(
          hintText: 'Timing',
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
        Row(
          children: [
            Expanded(
              child: InputField(
                hintText: 'State',
                controller: TextEditingController(),
              ),
            ),
            const WidthBox(10),
            SizedBox.fromSize(
              size: Size(75, 50),
              child: AppCountryPicker(onSelect: (val) {}),
            ),
          ],
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
