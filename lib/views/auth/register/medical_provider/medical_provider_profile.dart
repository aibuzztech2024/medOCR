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
    final MedicalProviderController medicalController = Get.put(
      MedicalProviderController(),
    );
    return Column(
      spacing: 16,
      children: [
        InputField(
          hintText: 'Business Name',
          controller: medicalController.businessNameController,
        ),

        InputField(
          hintText: 'Type Of Medical Provider',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: medicalController.medicalProviderTypeController,
        ),

        InputField(
          hintText: 'Services You Offer',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: medicalController.servicesController,
        ),
        InputField(
          hintText: 'Timing',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: medicalController.timingController,
        ),
        InputField(
          hintText: 'Website URL',
          controller: medicalController.websiteUrlController,
        ),
        InputField(
          hintText: 'Address',
          controller: medicalController.addressController,
        ),
        InputField(
          hintText: 'City/Town/District',
          controller: medicalController.cityController,
        ),
        Row(
          children: [
            Expanded(
              child: InputField(
                hintText: 'State',
                controller: medicalController.stateController,
              ),
            ),
            const WidthBox(10),
            SizedBox.fromSize(
              size: Size(75, 50),
              child: AppCountryPicker(
                onSelect: (val) {
                  medicalController.country.value = val;
                },
              ), //TODO Country code
            ),
          ],
        ),
        InputField(
          hintText: 'Pincode',
          controller: medicalController.pincodeController,
        ),
        InputField(
          hintText: 'Referral Code',
          controller: medicalController.referralCodeController,
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
