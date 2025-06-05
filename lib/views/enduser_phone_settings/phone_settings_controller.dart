import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'menu_item_model.dart';

/// Controller for Profile Settings Screen following MVVM pattern
/// Handles all business logic and data management using GetX
class ProfileSettingsController extends GetxController {
  // Observable user profile data
  // Using Rx to make it reactive for automatic UI updates
  final Rx<UserProfileModel> _userProfile =
      UserProfileModel(
        name: 'Guarav Yadav',
        email: 'guarav12@gmail.com',
        profileImageUrl:
            'https://img.freepik.com/free-photo/portrait-smiling-cute-little-girl_23-2147851843.jpg',
      ).obs;

  // Observable list of settings sections
  // Contains all the settings categories with their respective menu items
  final RxList<SettingsSection> _settingsSections = <SettingsSection>[].obs;

  // Loading state for async operations
  final RxBool _isLoading = false.obs;

  /// Getter for user profile data
  UserProfileModel get userProfile => _userProfile.value;

  /// Getter for settings sections
  List<SettingsSection> get settingsSections => _settingsSections;

  /// Getter for loading state
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    // Initialize settings sections when controller is created
    _initializeSettingsSections();
  }

  /// Initialize all settings sections with their menu items
  /// This method sets up the complete settings menu structure
  void _initializeSettingsSections() {
    _settingsSections.value = [
      // Account Settings Section
      SettingsSection(
        title: 'Account Settings',
        menuItems: [
          MenuItemModel(
            icon: Icons.person_outline_sharp,
            title: 'Account Information',
            onTap: () => _handleAccountInformation(),
          ),
          MenuItemModel(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () => _handleChangePassword(),
          ),
          MenuItemModel(
            icon: Icons.notifications_none_outlined,
            title: 'Notification',
            onTap: () => _handleNotificationSettings(),
          ),
        ],
      ),

      // Privacy Settings Section
      SettingsSection(
        title: 'Privacy Settings',
        menuItems: [
          MenuItemModel(
            icon: Icons.history_outlined,
            title: 'Clear Search History',
            onTap: () => _handleClearSearchHistory(),
          ),
          MenuItemModel(
            icon: Icons.paste_outlined,
            title: 'Clear Saved Data',
            onTap: () => _handleClearSavedData(),
          ),
          MenuItemModel(
            icon: Icons.delete_forever_outlined,
            title: 'Delete Account',
            onTap: () => _handleDeleteAccount(),
          ),
        ],
      ),

      // Terms and Conditions Section
      SettingsSection(
        title: 'Terms and Conditions',
        menuItems: [
          MenuItemModel(
            icon: Icons.file_present_outlined,
            title: 'Terms of Usage',
            onTap: () => _handleTermsOfUsage(),
          ),
          MenuItemModel(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () => _handlePrivacyPolicy(),
          ),
          MenuItemModel(
            icon: Icons.warning_amber_outlined,
            title: 'Disclaimer',
            onTap: () => _handleDisclaimer(),
          ),
        ],
      ),

      // Exit & Session Section
      SettingsSection(
        title: 'Exit & Session',
        menuItems: [
          MenuItemModel(
            icon: Icons.logout_outlined,
            title: 'Logout',
            iconColor: Colors.red,
            onTap: () => _handleLogout(),
          ),
        ],
      ),
    ];
  }

  /// Update user profile information
  /// [newProfile] - New user profile data to update
  void updateUserProfile(UserProfileModel newProfile) {
    _userProfile.value = newProfile;
  }

  // Menu item action handlers
  // These methods handle the business logic for each menu item

  /// Handle account information navigation
  void _handleAccountInformation() {
    // Navigate to account information screen
    Get.snackbar(
      'Account Information',
      'Navigating to account information screen',
      snackPosition: SnackPosition.BOTTOM,
    );
    // TODO: Add navigation logic here
    // Get.to(() => AccountInformationScreen());
  }

  /// Handle change password navigation
  void _handleChangePassword() {
    Get.snackbar(
      'Change Password',
      'Navigating to change password screen',
      snackPosition: SnackPosition.BOTTOM,
    );
    // TODO: Add navigation logic here
    // Get.to(() => ChangePasswordScreen());
  }

  /// Handle notification settings navigation
  void _handleNotificationSettings() {
    Get.snackbar(
      'Notification Settings',
      'Navigating to notification settings screen',
      snackPosition: SnackPosition.BOTTOM,
    );
    // TODO: Add navigation logic here
    // Get.to(() => NotificationSettingsScreen());
  }

  /// Handle clear search history action
  void _handleClearSearchHistory() {
    // Show confirmation dialog before clearing
    Get.dialog(
      AlertDialog(
        title: const Text('Clear Search History'),
        content: const Text(
          'Are you sure you want to clear your search history?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              // Perform clear search history logic
              Get.back();
              Get.snackbar(
                'Success',
                'Search history cleared successfully',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  /// Handle clear saved data action
  void _handleClearSavedData() {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear Saved Data'),
        content: const Text('Are you sure you want to clear all saved data?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              // Perform clear saved data logic
              Get.back();
              Get.snackbar(
                'Success',
                'Saved data cleared successfully',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  /// Handle delete account action
  void _handleDeleteAccount() {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              // Perform delete account logic
              Get.back();
              Get.snackbar(
                'Account Deletion',
                'Account deletion process initiated',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  /// Handle terms of usage navigation
  void _handleTermsOfUsage() {
    Get.snackbar(
      'Terms of Usage',
      'Opening terms of usage',
      snackPosition: SnackPosition.BOTTOM,
    );
    // TODO: Add navigation or web view logic here
  }

  /// Handle privacy policy navigation
  void _handlePrivacyPolicy() {
    Get.snackbar(
      'Privacy Policy',
      'Opening privacy policy',
      snackPosition: SnackPosition.BOTTOM,
    );
    // TODO: Add navigation or web view logic here
  }

  /// Handle disclaimer navigation
  void _handleDisclaimer() {
    Get.snackbar(
      'Disclaimer',
      'Opening disclaimer',
      snackPosition: SnackPosition.BOTTOM,
    );
    // TODO: Add navigation or web view logic here
  }

  /// Handle logout action
  void _handleLogout() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              // Perform logout logic
              Get.back();
              Get.snackbar(
                'Logout',
                'Logging out...',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
              // TODO: Add actual logout logic here
              // Clear user session, navigate to login screen, etc.
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
