import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/views/enduser_phone_settings/menu_item_model.dart';
import 'package:avatar/views/enduser_phone_settings/phone_settings_view_model.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/profile_card.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Profile Settings View following MVVM pattern
/// This is the UI layer that displays the profile settings screen
/// Uses GetX for state management and reactive UI updates
class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller using GetX dependency injection
    // Get.put ensures the controller is created and available
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<ProfileSettingsController>(
          init: ProfileSettingsController(), // Initialize controller
          builder: (controller) {
            return SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 22),

                      // Profile card section using reactive data from controller
                      _buildProfileSection(controller),

                      const SizedBox(height: 12),

                      // Settings sections built dynamically from controller data
                      _buildSettingsSections(controller),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Build the profile card section
  /// Uses Obx for reactive updates when user profile data changes
  /// [controller] - The controller containing user profile data
  Widget _buildProfileSection(ProfileSettingsController controller) {
    return Obx(() {
      final userProfile = controller.userProfile;
      return ProfileCardWidget(
        name: userProfile.name,
        email: userProfile.email,
        profileImageAsset: userProfile.profileImageAsset,
      );
    });
  }

  /// Build all settings sections dynamically
  /// Creates sections with titles and menu items from controller data
  /// [controller] - The controller containing settings sections data
  Widget _buildSettingsSections(ProfileSettingsController controller) {
    return Obx(() {
      // Check if data is loading
      if (controller.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      // Build each settings section
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            controller.settingsSections.map((section) {
              return _buildSettingsSection(section);
            }).toList(),
      );
    });
  }

  /// Build individual settings section with title and menu items
  /// [section] - The settings section model containing title and menu items
  Widget _buildSettingsSection(SettingsSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        AppText(
          section.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),

        // Settings menu widget with menu items
        SettingsMenuWidget(menuItems: section.menuItems),

        const SizedBox(height: 22),
      ],
    );
  }
}
