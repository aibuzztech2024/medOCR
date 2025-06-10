import 'package:avatar/views/enduser_phone_settings/edit_account_information_controller.dart';
import 'package:avatar/views/enduser_phone_settings/user_detail_model.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/country_code_picker.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/labeled_drop_down_button.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/labeled_text_field.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// View class for the Edit Details Screen following MVVM pattern
/// This class is responsible ONLY for UI rendering and user interaction handling
/// All business logic and state management is delegated to EditDetailsController
class EditAccountInformationView extends StatelessWidget {
  const EditAccountInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller using GetX dependency injection
    return GetBuilder<EditAccountInformationController>(
      init: EditAccountInformationController(),
      builder: (controller) => _buildScaffold(context, controller),
    );
  }

  /// Build the main scaffold structure with app bar, body, and bottom navigation
  Widget _buildScaffold(
    BuildContext context,
    EditAccountInformationController controller,
  ) {
    return Scaffold(
      // Custom app bar with back navigation
      appBar: _buildAppBar(context),

      // Main scrollable body content with responsive layout
      body: SafeArea(
        child: LayoutBuilder(
          builder:
              (context, constraints) =>
                  _buildResponsiveLayout(context, controller),
        ),
      ),

      // Bottom navigation bar with save/cancel functionality
      bottomNavigationBar: _buildBottomNavigationBar(controller),
    );
  }

  /// Build custom app bar with back button and title
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }

  /// Build responsive layout that adapts to different screen sizes
  Widget _buildResponsiveLayout(
    BuildContext context,
    EditAccountInformationController controller,
  ) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: controller.getContentWidth(context),
          child: Column(
            children: [
              SizedBox(height: controller.getTopSpacing(context)),
              _buildFormSection(context, controller),
            ],
          ),
        ),
      ),
    );
  }

  /// Build the main form section containing all input fields
  Widget _buildFormSection(
    BuildContext context,
    EditAccountInformationController controller,
  ) {
    return Column(
      children: [
        // Name input field
        _buildNameField(controller),
        SizedBox(height: controller.getVerticalSpacing(context)),

        // Email input field
        _buildEmailField(controller),
        SizedBox(height: controller.getVerticalSpacing(context)),

        // Phone number section with country picker
        _buildPhoneSection(controller),
        SizedBox(height: controller.getVerticalSpacing(context)),

        // Date of Birth input field
        _buildDateOfBirthField(controller),
        SizedBox(height: controller.getVerticalSpacing(context)),

        // Gender dropdown with reactive state
        _buildGenderDropdown(controller),
        SizedBox(height: controller.getVerticalSpacing(context)),

        // Country dropdown with reactive state
        _buildCountryDropdown(controller),
        SizedBox(height: controller.getVerticalSpacing(context)),

        // State and City section side by side
        _buildStateCitySection(context, controller),
        SizedBox(height: controller.getVerticalSpacing(context)),

        // Address input field
        _buildAddressField(controller),
        SizedBox(height: controller.getVerticalSpacing(context)),

        // Pincode input field
        _buildPincodeField(controller),
        SizedBox(
          height: controller.getVerticalSpacing(context) * 2,
        ), // Extra bottom spacing
      ],
    );
  }

  /// Build name input field connected to controller
  Widget _buildNameField(EditAccountInformationController controller) {
    return LabeledTextField(
      label: 'Name',
      controller: controller.nameController,
      hintText: 'Guarav',
    );
  }

  /// Build email input field connected to controller
  Widget _buildEmailField(EditAccountInformationController controller) {
    return LabeledTextField(
      label: 'Email',
      controller: controller.emailController,
      hintText: 'guarav@gmail.com',
    );
  }

  /// Build phone section with country code picker and phone input
  Widget _buildPhoneSection(EditAccountInformationController controller) {
    return Row(
      children: [
        // Country code picker widget - handles its own state
        StyledCountryPicker(
          onSelect: (value) {
            controller.onCountryCodeSelected(value);
          },
        ),

        // Phone number input field
        Expanded(
          child: LabeledTextField(
            label: 'Phone No.',
            controller: controller.phoneController,
            hintText: 'Enter phone number',
            keyboardType: TextInputType.phone,
          ),
        ),
      ],
    );
  }

  /// Build date of birth input field
  Widget _buildDateOfBirthField(EditAccountInformationController controller) {
    return LabeledTextField(
      label: 'Date of Birth',
      controller: controller.dobController,
      hintText: 'DD/MM/YYYY',
      keyboardType: TextInputType.datetime,
    );
  }

  /// Build gender dropdown with reactive state management
  Widget _buildGenderDropdown(EditAccountInformationController controller) {
    return Obx(
      () => LabeledDropdown<String>(
        label: 'Gender',
        hintText: 'Select Gender',
        value: controller.selectedGender,
        items:
            UserDetailsModel.genders.map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              );
            }).toList(),
        onChanged: (String? newValue) {
          controller.updateGender(newValue);
        },
      ),
    );
  }

  /// Build country dropdown with reactive state management
  Widget _buildCountryDropdown(EditAccountInformationController controller) {
    return Obx(
      () => LabeledDropdown<String>(
        label: 'Country',
        hintText: 'Select Country',
        value: controller.selectedCountry,
        items:
            UserDetailsModel.countries.map((String country) {
              return DropdownMenuItem<String>(
                value: country,
                child: Text(country),
              );
            }).toList(),
        onChanged: (String? newValue) {
          controller.updateCountry(newValue);
        },
      ),
    );
  }

  /// Build state and city section with two dropdowns side by side
  Widget _buildStateCitySection(
    BuildContext context,
    EditAccountInformationController controller,
  ) {
    return Row(
      children: [
        // State dropdown - takes half the width
        Expanded(child: _buildStateDropdown(controller)),

        // Small spacing between the two dropdowns
        SizedBox(width: controller.getVerticalSpacing(context) * 0.001),

        // City dropdown - takes half the width
        Expanded(child: _buildCityDropdown(controller)),
      ],
    );
  }

  /// Build state dropdown with reactive state management
  Widget _buildStateDropdown(EditAccountInformationController controller) {
    return Obx(
      () => LabeledDropdown<String>(
        label: 'State',
        hintText: 'Select State',
        value: controller.selectedState,
        items:
            UserDetailsModel.states.map((String state) {
              return DropdownMenuItem<String>(value: state, child: Text(state));
            }).toList(),
        onChanged: (String? newValue) {
          controller.updateState(newValue);
        },
      ),
    );
  }

  /// Build city dropdown with reactive state management
  Widget _buildCityDropdown(EditAccountInformationController controller) {
    return Obx(
      () => LabeledDropdown<String>(
        label: 'City',
        hintText: 'Select City',
        value: controller.selectedCity,
        items:
            UserDetailsModel.cities.map((String city) {
              return DropdownMenuItem<String>(value: city, child: Text(city));
            }).toList(),
        onChanged: (String? newValue) {
          controller.updateCity(newValue);
        },
      ),
    );
  }

  /// Build address input field connected to controller
  Widget _buildAddressField(EditAccountInformationController controller) {
    return LabeledTextField(
      label: 'Address',
      controller: controller.addressController,
      hintText: 'Enter address',
    );
  }

  /// Build pincode input field with numeric keyboard
  Widget _buildPincodeField(EditAccountInformationController controller) {
    return LabeledTextField(
      label: 'Pincode',
      controller: controller.pincodeController,
      hintText: '22317',
      keyboardType: TextInputType.number,
    );
  }

  /// Build bottom navigation bar with reactive loading state
  Widget _buildBottomNavigationBar(
    EditAccountInformationController controller,
  ) {
    return Obx(
      () => CustomNavBar(
        cancelText: 'Cancel',
        submitText: controller.isLoading ? 'Saving...' : 'Save Changes',
        // Disable buttons during loading to prevent multiple submissions
        onCancel:
            controller.isLoading
                ? null
                : () {
                  controller.cancelChanges();
                },
        onSubmit:
            controller.isLoading
                ? null
                : () {
                  controller.saveChanges();
                },
      ),
    );
  }
}
