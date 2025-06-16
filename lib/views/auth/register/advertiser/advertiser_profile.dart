import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/viewModels/auth/register/advertiser/advertiser_profile_controller.dart';
import 'package:avatar/views/advertiser/donate/donation_home_page_view.dart';
import 'package:avatar/views/auth/widget/app_country_picker.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/input_with_action.dart';
import 'package:avatar/views/auth/widget/policy_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvertiserProfile extends StatelessWidget {
  final VoidCallback onContinue;

  AdvertiserProfile({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final AdvertiserProfileController advertiserProfileController = Get.put(
      AdvertiserProfileController(),
    );
    return Column(
      spacing: 16,
      children: [
        InputField(
          hintText: 'Business Name',
          controller: advertiserProfileController.businessNameController,
        ),
        InputField(
          hintText: 'Advertiser Type',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: advertiserProfileController.advertiserTypeController,
        ),
        InputField(
          hintText: 'Ad Services Required',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: advertiserProfileController.adServicesController,
        ),
        InputField(
          hintText: 'Website URL',
          controller: TextEditingController(),
        ),
        InputField(
          hintText: 'Address',
          controller: advertiserProfileController.addressController,
        ),
        InputField(
          hintText: 'City/Town/District',
          controller: advertiserProfileController.cityController,
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'State',
            controller: TextEditingController(),
          ),
          trailingChild: AppCountryPicker(
            onSelect: (val) {},
          ), //TODO: country code
        ),
        InputField(
          hintText: 'Pincode',
          controller: advertiserProfileController.pincodeController,
        ),
        InputField(
          hintText: 'Referral Code',
          trailingIcon: Icons.keyboard_arrow_down,
          controller: advertiserProfileController.referralCodeController,
        ),
        PolicyCheckbox(onChange: (val) {}),
        AppButton(
          type: ButtonType.filled,
          text: 'Continue',
          width: double.infinity,
          onPressed: onContinue,
        ),
        AppButton(
          type: ButtonType.filled,
          text: 'Continue',
          width: double.infinity,
          onPressed: () => Get.to(DonationHomePageView()),
        ),
        SizedBox(),
      ],
    );
  }
}
