import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/viewModels/auth/register/client/client_profile_controller.dart';
import 'package:avatar/views/auth/widget/app_country_picker.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/input_with_action.dart';
import 'package:avatar/views/auth/widget/policy_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientProfile extends StatelessWidget {
  final VoidCallback onContinue;
  const ClientProfile({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final ClientController clientProfileController = Get.put(
      ClientController(),
    );
    return Column(
      spacing: 16,
      children: [
        InputField(
          hintText: 'Business Name',
          controller: clientProfileController.businessNameController,
        ),
        InputField(
          hintText: 'Company Type',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: clientProfileController.companyTypeController,
        ),
        InputField(
          hintText: 'Services Your Interested In',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: clientProfileController.servicesInterestedInController,
        ),
        InputField(
          hintText: 'Website URL',
          controller: clientProfileController.websiteUrlController,
        ),
        InputField(
          hintText: 'Address',
          controller: clientProfileController.addressController,
        ),
        InputField(
          hintText: 'City/Town/District',
          controller: clientProfileController.cityController,
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'State',
            controller: clientProfileController.stateController,
          ),
          trailingChild: AppCountryPicker(onSelect: (val) {}),
        ),
        InputField(
          hintText: 'Pincode',
          controller: clientProfileController.pincodeController,
        ),
        InputField(
          hintText: 'Referral Code',
          controller: clientProfileController.referralCodeController,
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
