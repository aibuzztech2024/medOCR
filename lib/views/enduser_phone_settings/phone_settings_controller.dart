import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/views/enduser_phone_settings/change_password_view.dart';
import 'package:avatar/views/enduser_phone_settings/edit_account_information_view.dart';
import 'package:avatar/views/enduser_phone_settings/notification_settings_view.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/custom_popup.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/labeled_text_field.dart';
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
    Get.to(() => const EditAccountInformationView());
  }

  /// Handle change password navigation
  void _handleChangePassword() {
    Get.to(() => const ChangePasswordView());
  }

  /// Handle notification settings navigation
  void _handleNotificationSettings() {
    Get.to(() => const NotificationSettingsView());
  }

  /// Handle clear search history action
  void _handleClearSearchHistory() {
    // Show confirmation dialog before clearing
    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              'Do you want clear your recent history',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  padding: EdgeInsets.zero,
                  height: 36,
                  width: 89,
                  type: ButtonType.outlined,
                  text: 'No',
                  onPressed: () => Get.back(),
                ),
                const SizedBox(width: 10),
                AppButton(
                  padding: EdgeInsets.zero,
                  height: 36,
                  width: 89,
                  color: Color(0xFFB0020A),
                  type: ButtonType.filled,
                  text: 'Yes',
                  onPressed:
                      () => Get.back(), // TODO: Add clear search history logic
                ),
              ],
            ),
            const SizedBox(height: 8),
            AppText('Your Saved data is cleared.✅'),
          ],
        ),
      ),
    );
  }

  /// Handle clear saved data action
  void _handleClearSavedData() {
    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              'Do you want clear your Saved Data',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  padding: EdgeInsets.zero,
                  height: 36,
                  width: 89,
                  type: ButtonType.outlined,
                  text: 'No',
                  onPressed: () => Get.back(),
                ),
                const SizedBox(width: 10),
                AppButton(
                  padding: EdgeInsets.zero,
                  height: 36,
                  width: 89,
                  color: Color(0xFFB0020A),
                  type: ButtonType.filled,
                  text: 'Yes',
                  onPressed:
                      () => Get.back(), // TODO: Add clear search history logic
                ),
              ],
            ),
            const SizedBox(height: 8),
            AppText('Your Saved data is cleared.✅'),
          ],
        ),
      ),
    );
  }

  /// Handle delete account action
  void _handleDeleteAccount() {
    String? selectedReason;
    TextEditingController otherReasonController = TextEditingController();

    final List<String> reasons = [
      'I found a better alternative',
      'The app is hard to use',
      'Not getting enough value',
      'Just taking a break',
      'Other (please specify)',
    ];

    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: Get.width * 0.95, // Set dialog width to 90% of screen width
          constraints: BoxConstraints(
            maxWidth: 400, // Maximum width for larger screens
            maxHeight: Get.height * 0.8, // Maximum height
          ),
          padding: EdgeInsets.all(24),
          child: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    AppText(
                      'Do you want to delete your profile ?',
                      style: TextStyle(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            color: Colors.black,
                            padding: EdgeInsets.zero,
                            height: 36,
                            type: ButtonType.outlined,
                            text: 'No',
                            onPressed: () => Get.back(),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AppButton(
                            padding: EdgeInsets.zero,
                            height: 36,
                            color: Color(0xFFB0020A),
                            type: ButtonType.filled,
                            text: 'Yes',
                            onPressed: () => Get.back(),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Sorry message
                    AppText(
                      'We are sorry you are going, Please select your reason',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(height: 10), // Reduced from 24
                    // Radio button options with reduced gaps
                    ...reasons.map((reason) {
                      return Container(
                        // Reduced from default spacing
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedReason = reason;
                            });
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  8, // Slightly increased for better touch target
                              horizontal: 4,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: AppText(
                                    reason,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Radio<String>(
                                  value: reason,
                                  groupValue: selectedReason,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedReason = value;
                                    });
                                  },
                                  activeColor: Color(0xFFFF9800),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize
                                          .shrinkWrap, // Reduces radio button size
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),

                    const SizedBox(height: 12), // Reduced from 16
                    // Text field for "Other" reason
                    LabeledTextField(
                      hintText: 'Specify your reason (10 words)',
                      borderColor: Colors.grey,
                      controller: otherReasonController,
                      hintStyle: TextStyle(color: Colors.black, fontSize: 13),
                    ),

                    const SizedBox(height: 20), // Reduced from 24
                    // Submit button
                    Center(
                      child: AppButton(
                        padding: EdgeInsets.zero,
                        height: 40,
                        width: 79,
                        color:
                            selectedReason != null
                                ? Color(0xFFFF9800)
                                : Colors.grey.shade300,
                        type: ButtonType.filled,
                        text: 'Submit',
                        onPressed: //TODO: Add account deletion logic
                            selectedReason != null
                                ? () {
                                  // Handle submit
                                  String reason = selectedReason!;
                                  String otherText = otherReasonController.text;

                                  // Log the selected reason
                                  print('Selected reason: $reason');
                                  if (reason == 'Other (please specify)' &&
                                      otherText.isNotEmpty) {
                                    print('Other reason: $otherText');
                                  }

                                  Get.back();

                                  // Show confirmation
                                  Get.snackbar(
                                    'Account Deletion',
                                    'Account deletion request submitted',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                  );

                                  // TODO: Add actual account deletion API call here
                                  // _performAccountDeletion(reason, otherText);
                                }
                                : null,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleTermsOfUsage() {
    ReusablePopupDialog.show(
      context: Get.context!,
      title: 'Terms of Usage',
      sections: [
        const DialogSection(
          title: '1. Introduction',
          content:
              'Welcome to Avatar ("Company", "we", "our", "us")! '
              'These Terms of Service ("Terms", "Terms of Service") govern your '
              'use of our mobile application and services (together or individually "Service") '
              'operated by Avatar. Our Privacy Policy also governs your use of our Service '
              'and explains how we collect, safeguard and disclose information that results from your use of our services. '
              'Your agreement with these Terms includes these Terms and our Privacy Policy ("Agreements"). '
              'By visiting our application you acknowledge that you have read and understood Agreements, '
              'and agree to be bound by them.',
        ),
        const DialogSection(
          title: '2. Communications',
          content:
              'By using our Service, you agree to subscribe to newsletters, '
              'marketing or promotional materials and other information we may send. '
              'However, you may opt out of receiving any, or all, of these communications from us '
              'by following the unsubscribe link or by contacting us through the app settings. '
              'If you do not agree with (or cannot comply with) these Terms, you may not use the Service. '
              'However, please let us know by emailing our support team, so we can try to find a solution. ',
        ),
      ],
      barrierDismissible: true,
      sectionBackgroundColor: Colors.orange.shade50,
      sectionSpacing: 16,
    );
  }

  /// Handle privacy policy navigation
  void _handlePrivacyPolicy() {
    ReusablePopupDialog.show(
      context: Get.context!,
      title: 'Privacy Policy',
      sections: [
        const DialogSection(
          title: '1. Introduction',
          content:
              'Welcome to Avatar ("Company", "we", "our", "us")! '
              'These Terms of Service ("Terms", "Terms of Service") govern your '
              'use of our mobile application and services (together or individually "Service") '
              'operated by Avatar. Our Privacy Policy also governs your use of our Service '
              'and explains how we collect, safeguard and disclose information that results from your use of our services. '
              'Your agreement with these Terms includes these Terms and our Privacy Policy ("Agreements"). '
              'By visiting our application you acknowledge that you have read and understood Agreements, '
              'and agree to be bound by them.',
        ),
        const DialogSection(
          title: '2. Communications',
          content:
              'By using our Service, you agree to subscribe to newsletters, '
              'marketing or promotional materials and other information we may send. '
              'However, you may opt out of receiving any, or all, of these communications from us '
              'by following the unsubscribe link or by contacting us through the app settings. '
              'If you do not agree with (or cannot comply with) these Terms, you may not use the Service. '
              'However, please let us know by emailing our support team, so we can try to find a solution. ',
        ),
      ],
      barrierDismissible: true,
      sectionBackgroundColor: Colors.orange.shade50,
      sectionSpacing: 16,
    );
    // TODO: Add navigation or web view logic here
  }

  /// Handle disclaimer navigation
  void _handleDisclaimer() {
    ReusablePopupDialog.show(
      context: Get.context!,
      title: 'Disclaimer',
      sections: [
        const DialogSection(
          title: '1. Introduction',
          content:
              'Welcome to Avatar ("Company", "we", "our", "us")! '
              'These Terms of Service ("Terms", "Terms of Service") govern your '
              'use of our mobile application and services (together or individually "Service") '
              'operated by Avatar. Our Privacy Policy also governs your use of our Service '
              'and explains how we collect, safeguard and disclose information that results from your use of our services. '
              'Your agreement with these Terms includes these Terms and our Privacy Policy ("Agreements"). '
              'By visiting our application you acknowledge that you have read and understood Agreements, '
              'and agree to be bound by them.',
        ),
        const DialogSection(
          title: '2. Communications',
          content:
              'By using our Service, you agree to subscribe to newsletters, '
              'marketing or promotional materials and other information we may send. '
              'However, you may opt out of receiving any, or all, of these communications from us '
              'by following the unsubscribe link or by contacting us through the app settings. '
              'If you do not agree with (or cannot comply with) these Terms, you may not use the Service. '
              'However, please let us know by emailing our support team, so we can try to find a solution. ',
        ),
      ],
      barrierDismissible: true,
      sectionBackgroundColor: Colors.orange.shade50,
      sectionSpacing: 16,
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
