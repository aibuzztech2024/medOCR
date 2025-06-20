import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/width_box.dart';
import 'package:avatar/viewModels/auth/register/medical_provider/medical_provider_controller.dart';
import 'package:avatar/views/auth/widget/app_country_picker.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/policy_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalProviderProfile extends StatelessWidget {
  final VoidCallback onContinue;
  const MedicalProviderProfile({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final MedicalProviderController medicalProfileController = Get.put(
      MedicalProviderController(),
    );
    return Column(
      spacing: 16,
      children: [
        InputField(
          hintText: 'Business Name',
          controller: medicalProfileController.businessNameController,
        ),

        InputField(
          hintText: 'Type Of Medical Provider',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: medicalProfileController.medicalProviderTypeController,
        ),

        InputField(
          hintText: 'Services You Offer',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: medicalProfileController.servicesController,
        ),
        InputField(
          hintText: 'Timing',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: medicalProfileController.timingController,
        ),
        InputField(
          hintText: 'Website URL',
          controller: medicalProfileController.websiteUrlController,
        ),
        InputField(
          hintText: 'Address',
          controller: medicalProfileController.addressController,
        ),
        InputField(
          hintText: 'City/Town/District',
          controller: medicalProfileController.cityController,
        ),
        Row(
          children: [
            Expanded(
              child: InputField(
                hintText: 'State',
                controller: medicalProfileController.stateController,
              ),
            ),
            const WidthBox(10),
            SizedBox.fromSize(
              size: Size(75, 50),
              child: AppCountryPicker(onSelect: (val) {}), //TODO Country code
            ),
          ],
        ),
        InputField(
          hintText: 'Pincode',
          controller: medicalProfileController.pincodeController,
        ),
        InputField(
          hintText: 'Referral Code',
          controller: medicalProfileController.referralCodeController,
        ),
        PolicyCheckbox(onChange: (val) {}), //TODO Policy Check
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
