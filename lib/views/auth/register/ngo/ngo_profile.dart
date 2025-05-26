import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/viewModels/auth/register/ngo/ngo_controller.dart';
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
    // Get or create the controller
    final controller =
        Get.isRegistered<NgoController>()
            ? Get.find<NgoController>()
            : Get.put(NgoController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputField(
          hintText: 'NGO Name',
          controller: controller.ngoNameController,
        ),
        SizedBox(height: 16),
        InputField(
          hintText: 'NGO Service',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: controller.ngoServiceController,
        ),
        SizedBox(height: 16),
        InputField(
          hintText: 'Website URL',
          controller: controller.websiteUrlController,
        ),
        SizedBox(height: 16),
        InputField(
          hintText: 'Address',
          controller: controller.addressController,
        ),
        SizedBox(height: 16),
        InputField(
          hintText: 'City/Town/District',
          controller: controller.cityController,
        ),
        SizedBox(height: 16),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'State',
            controller: controller.stateController,
          ),
          trailingChild: AppCountryPicker(
            onSelect: (val) {
              // Optionally update state or country-related logic here
            },
          ),
        ),
        SizedBox(height: 16),
        InputField(
          hintText: 'Pincode',
          controller: controller.pincodeController,
        ),
        SizedBox(height: 16),
        InputField(
          hintText: 'Referral Code',
          controller: controller.referralCodeController,
        ),
        SizedBox(height: 16),
        Obx(
          () => PolicyCheckbox(
            onChange: (val) {
              controller.isPolicyAccepted.value = val as bool;
            },
            message: 'I Agree To The Terms & Privacy Policy',
          ),
        ),
        SizedBox(height: 16),
        AppButton(
          type: ButtonType.filled,
          text: 'Continue',
          onPressed: onContinue,
          width: double.infinity,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
