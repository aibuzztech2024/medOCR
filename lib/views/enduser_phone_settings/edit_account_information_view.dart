import 'package:avatar/views/enduser_phone_settings/edit_account_information_viewmodel.dart.dart';
import 'package:avatar/views/enduser_phone_settings/user_detail_model.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/country_code_picker.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/labeled_drop_down_button.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/labeled_text_field.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// MVVM View for editing user account information
/// Handles UI rendering and delegates business logic to controller
class EditAccountInformationView extends StatelessWidget {
  const EditAccountInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller using GetX dependency injection
    return GetBuilder<EditAccountInformationController>(
      init: EditAccountInformationController(),
      builder:
          (controller) => Scaffold(
            // Custom app bar with back navigation and title
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              titleSpacing: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Get.back(),
              ),
              title: const Text(
                'Edit Account Information',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            // Scrollable body with responsive layout and form fields
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: controller.getContentWidth(
                      context,
                    ), // Responsive width
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: controller.getTopSpacing(context) * 0.3,
                        ),
                        ..._buildFormFields(
                          context,
                          controller,
                        ), // Spread operator for form fields
                        SizedBox(
                          height: controller.getVerticalSpacing(context) * 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Bottom navigation with reactive loading state
            bottomNavigationBar: Obx(
              () => CustomNavBar(
                cancelText: 'Cancel',
                submitText: controller.isLoading ? 'Saving...' : 'Save Change',
                onCancel:
                    controller.isLoading
                        ? null
                        : controller.cancelChanges, // Disable during loading
                onSubmit:
                    controller.isLoading
                        ? null
                        : controller
                            .saveChanges, // Prevent multiple submissions
              ),
            ),
          ),
    );
  }

  /// Builds all form fields with consistent spacing and validation
  /// Returns list of widgets to be spread into main column
  List<Widget> _buildFormFields(
    BuildContext context,
    EditAccountInformationController controller,
  ) {
    final spacing = controller.getVerticalSpacing(
      context,
    ); // Cache spacing value
    return [
      // Basic text fields for name and email
      LabeledTextField(
        label: 'Name',
        controller: controller.nameController,
        hintText: 'Gaurav',
      ),
      SizedBox(height: spacing),

      LabeledTextField(
        label: 'Email',
        controller: controller.emailController,
        hintText: 'guarav@gmail.com',
      ),
      SizedBox(height: spacing),

      // Phone section: country code picker + phone input
      Row(
        children: [
          StyledCountryPicker(onSelect: controller.onCountryCodeSelected),
          SizedBox(width: spacing * 0.5),
          Expanded(
            child: LabeledTextField(
              label: 'Phone No.',
              controller: controller.phoneController,
              hintText: 'Enter phone number',
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
      SizedBox(height: spacing),

      // Date of birth with calendar picker
      LabeledTextField(
        label: 'Date of Birth',
        controller: controller.dobController,
        hintText: 'DD/MM/YYYY',
        keyboardType: TextInputType.datetime,
        suffixIcon: IconButton(
          onPressed: () async {
            // Show native date picker with custom styling
            final picked = await showDatePicker(
              initialEntryMode: DatePickerEntryMode.calendar,
              initialDatePickerMode: DatePickerMode.year,
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              builder:
                  (context, child) => Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white,
                        surface: Colors.white,
                        onSurface: Colors.black,
                      ),
                    ),
                    child: child!,
                  ),
            );
            // Format and set selected date
            if (picked != null) {
              controller.dobController.text =
                  '${picked.day}/${picked.month}/${picked.year}';
            }
          },
          icon: const Icon(Icons.calendar_month_outlined),
        ),
      ),
      SizedBox(height: spacing),

      // Gender dropdown with reactive state
      Obx(
        () => LabeledDropdown<String>(
          label: 'Gender',
          hintText: 'Select Gender',
          value: controller.selectedGender,
          items:
              UserDetailsModel.genders
                  .map(
                    (gender) =>
                        DropdownMenuItem(value: gender, child: Text(gender)),
                  )
                  .toList(),
          onChanged: controller.updateGender,
        ),
      ),
      SizedBox(height: spacing),

      // Country dropdown with reactive state
      Obx(
        () => LabeledDropdown<String>(
          label: 'Country',
          hintText: 'Select Country',
          value: controller.selectedCountry,
          items:
              UserDetailsModel.countries
                  .map(
                    (country) =>
                        DropdownMenuItem(value: country, child: Text(country)),
                  )
                  .toList(),
          onChanged: controller.updateCountry,
        ),
      ),
      SizedBox(height: spacing),

      // State and City dropdowns side by side
      Row(
        children: [
          Expanded(
            child: Obx(
              () => LabeledDropdown<String>(
                label: 'State',
                hintText: 'Select State',
                value: controller.selectedState,
                items:
                    UserDetailsModel.states
                        .map(
                          (state) => DropdownMenuItem(
                            value: state,
                            child: Text(state),
                          ),
                        )
                        .toList(),
                onChanged: controller.updateState,
              ),
            ),
          ),
          SizedBox(width: spacing * 0.5),
          Expanded(
            child: Obx(
              () => LabeledDropdown<String>(
                label: 'City',
                hintText: 'Select City',
                value: controller.selectedCity,
                items:
                    UserDetailsModel.cities
                        .map(
                          (city) =>
                              DropdownMenuItem(value: city, child: Text(city)),
                        )
                        .toList(),
                onChanged: controller.updateCity,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: spacing),

      // Address and pincode fields
      LabeledTextField(
        label: 'Address',
        controller: controller.addressController,
        hintText: 'Enter address',
      ),
      SizedBox(height: spacing),

      LabeledTextField(
        label: 'Pincode',
        controller: controller.pincodeController,
        hintText: '22317',
        keyboardType: TextInputType.number, // Numeric keyboard for numbers
      ),
    ];
  }
}
