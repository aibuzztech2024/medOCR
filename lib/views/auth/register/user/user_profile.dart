import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/height_box.dart';
import 'package:avatar/core/widgets/width_box.dart';
import 'package:avatar/viewModels/auth/register/user/register_controller.dart';
import 'package:avatar/views/auth/widget/app_country_picker.dart';
import 'package:avatar/views/auth/widget/app_upload_button.dart';
import 'package:avatar/views/auth/widget/gender_selector.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/input_with_action.dart';
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
        InputField(
          hintText: 'Name',
          controller:
              registerController
                  .nameController, // Replace with persistent controller if needed
        ),
        HeightBox(16),

        Row(
          children: [
            Expanded(
              flex: 1,
              child: InputField(
                hintText: 'DOB',
                controller: registerController.dobController,
                trailingIcon: Icons.calendar_month,
                onTrailingIconTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    // Format the date as per your need
                    final formattedDate =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    registerController.dobController.text = formattedDate;
                  }
                },
              ),
            ),

            WidthBox(10), // spacing between the two halves
            Expanded(
              flex: 1,
              child: AppButton(
                type: ButtonType.outlined,
                onPressed: () async {
                  // Show selector and update value
                  registerController.gender.value = await showGenderSelector(
                    context,
                  );
                },
                child: Obx(() {
                  // Map values to display text
                  String genderText;
                  switch (registerController.gender.value) {
                    case 'M':
                      genderText = 'Male';
                      break;
                    case 'F':
                      genderText = 'Female';
                      break;
                    case 'O':
                      genderText = 'Other';
                      break;
                    default:
                      genderText = 'Gender'; // Default label
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(genderText, style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down, size: 20),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),

        HeightBox(16),

        // Address field
        InputField(
          hintText: 'Address',
          controller: registerController.addressController,
        ),
        HeightBox(16),

        // City or District field
        InputField(
          hintText: 'City/Town/District',
          controller: registerController.cityController,
        ),
        HeightBox(16),

        // Row for State and Country Picker
        Row(
          children: [
            Expanded(
              child: InputField(
                hintText: 'State',
                controller: registerController.stateController,
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
        InputField(
          hintText: 'Pincode',
          controller: registerController.pincodeController,
        ),
        HeightBox(16),

        // Referral Code field
        InputField(
          hintText: 'Referral Code',
          controller: registerController.referralCodeController,
        ),
        HeightBox(16),

        // Selfie Upload Section
        InputWithAction(
          expandedChild: InputField(
            hintText: 'Selfie saptured successfully',
            controller: registerController.selfieController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              registerController.selfieController;
            },
          ),
        ),
        HeightBox(16),

        // Checkbox for accepting privacy policy
        PolicyCheckbox(
          onChange: (val) {
            registerController.isPrivacyPolicyAccepted = val! as bool;
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
