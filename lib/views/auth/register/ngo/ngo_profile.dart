import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/viewModels/auth/register/ngo/ngo_profile_controller.dart';
import 'package:avatar/views/auth/widget/app_country_picker.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/input_with_action.dart';
import 'package:avatar/views/auth/widget/policy_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NgoProfile extends StatelessWidget {
  final VoidCallback onContinue;
  const NgoProfile({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final NgoProfileController ngoProfileController = Get.put(
      NgoProfileController(),
    );
    return Column(
      spacing: 16,
      children: [
        InputField(
          hintText: 'NGO Name',
          controller: ngoProfileController.nameController,
        ),
        InputField(
          hintText: 'NGO Service',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: ngoProfileController.serviceController,
        ),
        InputField(
          hintText: 'Website URL',
          controller: ngoProfileController.websiteController,
        ),
        InputField(
          hintText: 'Address',
          controller: ngoProfileController.addressController,
        ),
        InputField(
          hintText: 'City/Town/District',
          controller: ngoProfileController.cityController,
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'State',
            controller: ngoProfileController.stateController,
          ),
          trailingChild: AppCountryPicker(
            onSelect: (val) {},
          ), //TODO Country Code
        ),
        InputField(
          hintText: 'Pincode',
          controller: ngoProfileController.pincodeController,
        ),
        InputField(
          hintText: 'Referral Code',
          controller: ngoProfileController.referralController,
        ),
        PolicyCheckbox(
          onChange: (val) {},
          message: 'I Agree To The Terms & Privacy Policy',
        ),
        AppButton(
          type: ButtonType.filled,
          text: 'Continue',
          onPressed: onContinue,
          width: double.infinity,
        ),
        SizedBox(),
      ],
    );
  }
}
