// ============================================================================
// VIEW: UI layer with responsive design
// ============================================================================
import 'package:avatar/views/enduser_phone_settings/edit_profile_view_model.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/country_code_picker.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/custom_navbar.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/labeled_text_field.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Main view for account information page with responsive design
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ViewModel
    final viewModel = Get.put(EditProfileViewModel());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => _buildResponsiveLayout(viewModel),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        cancelText: 'Cancel',
        submitText: 'Submit',
        onCancel: () {
          // Handle cancel action
          Navigator.pop(context);
        },
        onSubmit: () {
          //TODO: Handle submit action
          // Handle save changes action
        },
      ),
    );
  }

  /// Build responsive layout that adapts to different screen sizes
  Widget _buildResponsiveLayout(EditProfileViewModel viewModel) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: _getContentWidth(),
          // Add bottom padding to account for the navigation bar
          padding: EdgeInsets.only(
            bottom: _getVerticalSpacing(),
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            children: [
              SizedBox(height: _getTopSpacing()),
              _buildProfileSection(),
              SizedBox(height: _getVerticalSpacing()),
              _buildFormSection(viewModel),
              // Add extra spacing at bottom for better scrolling
              SizedBox(height: _getVerticalSpacing() * 2),
            ],
          ),
        ),
      ),
    );
  }

  /// Build profile image section
  Widget _buildProfileSection() {
    final args = Get.arguments;
    final viewModel = Get.find<EditProfileViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ProfileImageWidget(
        showEditButton: true,
        imageUrl: 'assets/images/character_1.png',
        onEditPressed: viewModel.navigateToEditAvatar,
      ),
    );
  }

  /// Build form fields section
  Widget _buildFormSection(EditProfileViewModel viewModel) {
    return Column(
      children: [
        // Name input field
        LabeledTextField(
          label: 'Name',
          controller: viewModel.nameController,
          hintText: 'Guarav Yadav',
        ),

        SizedBox(height: _getVerticalSpacing()),

        // Email input field
        LabeledTextField(
          label: 'Email Address',
          controller: viewModel.emailController,
          hintText: 'guarav@gmail.com',
        ),

        SizedBox(height: _getVerticalSpacing()),

        // Phone number section with country picker
        _buildPhoneSection(viewModel),
      ],
    );
  }

  /// Build phone number input section with country picker
  Widget _buildPhoneSection(EditProfileViewModel viewModel) {
    return Row(
      children: [
        // Country code picker
        StyledCountryPicker(onSelect: viewModel.onCountrySelected),

        SizedBox(width: _getVerticalSpacing() * 0.5),

        // Phone number input field
        Expanded(
          child: LabeledTextField(
            label: 'Phone No.',
            controller: viewModel.phoneController,
            hintText: 'Enter phone number',
            keyboardType: TextInputType.phone,
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // RESPONSIVE DESIGN HELPERS: Calculate dimensions based on screen size
  // =========================================================================

  /// Get content width based on screen size
  double _getContentWidth() {
    if (Get.width > 900) return Get.width * 0.6; // Desktop: 60% width
    if (Get.width > 600) return Get.width * 0.8; // Tablet: 80% width
    return Get.width; // Mobile: Full width
  }

  /// Get top spacing based on screen height
  double _getTopSpacing() {
    return (Get.height * 0.04).clamp(30.0, 50.0);
  }

  /// Get vertical spacing between elements
  double _getVerticalSpacing() {
    return (Get.height * 0.025).clamp(20.0, 30.0);
  }
}
