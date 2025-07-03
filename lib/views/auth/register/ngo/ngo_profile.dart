import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/viewModels/auth/register/ngo/ngo_register_controller.dart';
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
    // ✅ Access the RegisterController
    final registerController = Get.find<NgoRegisterController>();

    return Column(
      spacing: 16,
      children: [
        InputField(
          hintText: 'NGO Name',
          controller: registerController.ngoNameController,
        ),
        InputField(
          hintText: 'NGO Service',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: registerController.ngoServicesController,
        ),
        InputField(
          hintText: 'Website URL',
          controller: registerController.websiteUrlController,
        ),
        InputField(
          hintText: 'Address',
          controller: registerController.addressController,
        ),
        InputField(
          hintText: 'City/Town/District',
          controller: registerController.distController,
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'State',
            controller: registerController.stateController,
          ),
          trailingChild: AppCountryPicker(
            onSelect: (val) {
              registerController.countryController.text = val.name;
            },
          ),
        ),
        InputField(
          hintText: 'Pincode',
          controller: registerController.pincodeController,
        ),
        InputField(
          hintText: 'Referral Code',
          controller: registerController.referralController,
        ),
        PolicyCheckbox(
          onChange: (val) {
            // Optionally store checkbox state in controller using RxBool
          },
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
