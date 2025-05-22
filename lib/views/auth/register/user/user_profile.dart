import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/height_box.dart';
import 'package:avatar/core/widgets/width_box.dart';
import 'package:avatar/viewModels/auth/register/register_controller.dart';
import 'package:avatar/views/auth/widget/app_country_picker.dart';
import 'package:avatar/views/auth/widget/gender_selector.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/policy_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A widget for collecting user profile details as part of the registration process.
/// Includes inputs for name, address, gender, and agreement to terms of service.
class UserProfile extends StatelessWidget {
  /// Callback to proceed to the next step in registration.
  final VoidCallback onContinue;

  const UserProfile({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    // Retrieve the RegisterController using GetX
    var registerController =
        Get.isRegistered<RegisterController>()
            ? Get.find<RegisterController>()
            : Get.put(RegisterController());

    return Column(
      children: [
        // Row for Name input and Gender selection
        Row(
          children: [
            Expanded(
              flex: 1,
              child: InputField(
                hintText: 'Name',
                controller:
                    TextEditingController(), // Replace with persistent controller if needed
              ),
            ),
            WidthBox(10), // Horizontal spacing
            SizedBox(
              width: 75,
              height: 50,
              child: AppButton(
                type: ButtonType.outlined,
                onPressed: () async {
                  // Show gender selector and update the value in controller
                  registerController.gender.value = await showGenderSelector(
                    context,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Icon(
                        // Icon changes based on selected gender
                        registerController.gender.value == 'M'
                            ? Icons.male
                            : registerController.gender.value == 'F'
                            ? Icons.female
                            : Icons.transgender,
                        size: 26,
                      ),
                    ),
                    WidthBox(3),
                    Icon(Icons.keyboard_arrow_down, size: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
        HeightBox(16),

        // Address field
        InputField(hintText: 'Address', controller: TextEditingController()),
        HeightBox(16),

        // City or District field
        InputField(
          hintText: 'City/Town/District',
          controller: TextEditingController(),
        ),
        HeightBox(16),

        // Row for State and Country Picker
        Row(
          children: [
            Expanded(
              child: InputField(
                hintText: 'State',
                controller: TextEditingController(),
              ),
            ),
            WidthBox(10),
            AppCountryPicker(
              onSelect: (val) {
                // Handle selected country value if needed
              },
            ),
          ],
        ),
        HeightBox(16),

        // Pincode field
        InputField(hintText: 'Pincode', controller: TextEditingController()),
        HeightBox(16),

        // Referral Code field
        InputField(
          hintText: 'Referral Code',
          controller: TextEditingController(),
        ),
        HeightBox(16),

        // Checkbox for accepting privacy policy
        PolicyCheckbox(
          onChange: (val) {
            registerController.isPrivacyPolicyAccepted = val!;
          },
        ),
        HeightBox(16),

        // Continue Button
        AppButton(
          width: double.infinity,
          type: ButtonType.filled,
          onPressed: onContinue, // Calls the parent-provided callback
          text: 'Continue',
        ),
      ],
    );
  }
}
