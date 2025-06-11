import 'package:avatar/views/enduser_phone_settings/change_password_viewmodel.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/labeled_text_button.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/labeled_text_field.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// StatelessWidget that represents the Change Password screen using GetX
/// This widget is responsible only for UI presentation and user interaction
/// All business logic is delegated to the ChangePasswordController
/// GetX automatically manages the controller lifecycle
class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  /// Builds the UI for the Change Password screen
  /// Uses GetX's dependency injection to access the controller
  /// GetBuilder and Obx widgets handle reactive UI updates
  @override
  Widget build(BuildContext context) {
    // Initialize the controller using GetX dependency injection
    // GetX will automatically dispose of this controller when no longer needed
    final controller = Get.put(ChangePasswordController());

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(controller),
      bottomNavigationBar: CustomNavBar(
        cancelText: 'Cancel',
        submitText: 'Change',
        onCancel: () => Get.back(),
        onSubmit: () => controller.changePassword(),
      ),
    );
  }

  /// Builds the app bar with back navigation and title
  /// Separated into its own method for better code organization and readability
  /// [context] - BuildContext for accessing theme and navigation
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      // Use theme's scaffold background color for seamless integration
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0, // Flat design without shadow
      titleSpacing: 0, // Remove default title spacing for custom layout
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        // Use GetX navigation instead of Navigator for consistency
        onPressed: () => Get.back(),
      ),
      title: const Text(
        'Change Password',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  /// Builds the main body content with password input fields
  /// Uses GetBuilder to listen for controller changes and rebuild when necessary
  /// [controller] - The ChangePasswordController instance managing the form state
  Widget _buildBody(ChangePasswordController controller) {
    return GetBuilder<ChangePasswordController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            children: [
              // Current password display (read-only)
              LabeledTextDisplay(
                label: 'Current Password',
                value: controller.currentPasswordDisplay,
              ),

              // Responsive vertical spacing between fields
              SizedBox(height: _getVerticalSpacing(Get.context!)),

              // New password input field
              LabeledTextField(
                label: 'New Password',
                controller: controller.newPasswordController,
                isPassword: true, // Hide password input for security
              ),

              // Responsive vertical spacing between fields
              SizedBox(height: _getVerticalSpacing(Get.context!)),

              // Retype password input field for confirmation
              LabeledTextField(
                label: 'Retype Password',
                controller: controller.retypePasswordController,
                isPassword: true, // Hide password input for security
              ),

              // Add some spacing before potential action buttons
              SizedBox(height: _getVerticalSpacing(Get.context!) * 2),

              // Optional: Add a submit button with loading state
              // Uncomment the following lines if you want to add a submit button
              /*
              Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value 
                  ? null 
                  : () => controller.changePassword(),
                child: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : const Text('Change Password'),
              )),
              */
            ],
          ),
        );
      },
    );
  }

  /// Calculates responsive vertical spacing between form elements
  /// The spacing adapts to different screen sizes while maintaining good UX
  /// [context] - BuildContext for accessing screen dimensions
  /// Returns a double value representing the spacing in logical pixels
  double _getVerticalSpacing(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // Calculate 2.5% of screen height, clamped between 20 and 30 pixels
    // This ensures consistent spacing across different device sizes
    return (screenHeight * 0.025).clamp(20.0, 30.0);
  }
}
