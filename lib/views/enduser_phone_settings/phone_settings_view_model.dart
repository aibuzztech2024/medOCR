import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/views/enduser_phone_settings/change_password_view.dart';
import 'package:avatar/views/enduser_phone_settings/edit_account_information_view.dart';
import 'package:avatar/views/enduser_phone_settings/notification_settings_view.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/custom_popup.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/confirmation_dialog.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/account_deletion_dialog.dart';
import 'package:avatar/views/enduser_phone_settings/services/settings_service.dart';
import 'package:avatar/views/enduser_phone_settings/constants/settings_constants.dart';
import 'package:avatar/views/hospital/prescription_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'menu_item_model.dart';

/// Controller for Profile Settings Screen following MVVM pattern
/// Handles all business logic and data management using GetX
class ProfileSettingsController extends GetxController {
  // Services
  late final SettingsService _settingsService;

  // Observable user profile data
  final Rx<UserProfileModel> _userProfile =
      SettingsConstants.defaultUserProfile.obs;

  // Observable list of settings sections
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
    // Initialize service
    _settingsService = Get.put(SettingsService());
    _initializeSettingsSections();
  }

  /// Initialize all settings sections with their menu items
  void _initializeSettingsSections() {
    _settingsSections.value = [
      _buildAccountSettingsSection(),
      _buildPrivacySettingsSection(),
      _buildTermsSection(),
      _buildExitSection(),
    ];
  }

  /// Build Account Settings Section
  SettingsSection _buildAccountSettingsSection() {
    return SettingsSection(
      title: 'Account Settings',
      menuItems: [
        MenuItemModel.withSvg(
          svgAsset:
              'assets/icons/settings_section/home_page/account_information_icon.svg',
          title: 'Account Information',
          onTap: () => _handleAccountInformation(),
        ),
        MenuItemModel.withSvg(
          svgAsset:
              'assets/icons/settings_section/home_page/change_password_2.svg',
          title: 'Change Password',
          onTap: () => _handleChangePassword(),
        ),
        MenuItemModel.withSvg(
          svgAsset:
              'assets/icons/settings_section/home_page/notification_icon.svg',
          title: 'Notification',
          onTap: () => _handleNotificationSettings(),
        ),
      ],
    );
  }

  /// Build Privacy Settings Section
  SettingsSection _buildPrivacySettingsSection() {
    return SettingsSection(
      title: 'Privacy Settings',
      menuItems: [
        MenuItemModel.withSvg(
          svgAsset:
              'assets/icons/settings_section/home_page/clear_search_icon.svg',
          title: 'Clear Search History',
          onTap: () => _handleClearSearchHistory(),
        ),
        MenuItemModel.withSvg(
          svgAsset:
              'assets/icons/settings_section/home_page/clear_saved_data_icon.svg',
          title: 'Clear Saved Data',
          onTap: () => _handleClearSavedData(),
        ),
        MenuItemModel.withSvg(
          svgAsset:
              'assets/icons/settings_section/home_page/delete_account_icon.svg',
          title: 'Delete Account',
          onTap: () => _handleDeleteAccount(),
        ),
      ],
    );
  }

  /// Build Terms and Conditions Section
  SettingsSection _buildTermsSection() {
    return SettingsSection(
      title: 'Terms and Conditions',
      menuItems: [
        MenuItemModel.withSvg(
          svgAsset:
              'assets/icons/settings_section/home_page/terms_of_usage_icon.svg',
          title: 'Terms of Usage',
          onTap: () => _handleTermsOfUsage(),
          showArrow: false,
        ),
        MenuItemModel.withSvg(
          svgAsset:
              'assets/icons/settings_section/home_page/privacy_policy_icon.svg',
          title: 'Privacy Policy',
          onTap: () => _handlePrivacyPolicy(),
          showArrow: false,
        ),
        MenuItemModel.withSvg(
          svgAsset:
              'assets/icons/settings_section/home_page/disclaimer_icon.svg',
          title: 'Disclaimer',
          onTap: () => _handleDisclaimer(),
          showArrow: false,
        ),
      ],
    );
  }

  /// Build Exit & Session Section
  SettingsSection _buildExitSection() {
    return SettingsSection(
      title: 'Exit & Session',
      menuItems: [
        MenuItemModel.withSvg(
          svgAsset: 'assets/icons/settings_section/home_page/logout_2_icon.svg',
          iconColor: Colors.red,
          title: 'Logout',
          onTap: () => _handleLogout(),
        ),
      ],
    );
  }

  /// Update user profile information
  void updateUserProfile(UserProfileModel newProfile) {
    _userProfile.value = newProfile;
  }

  // Menu item action handlers
  void _handleAccountInformation() {
    Get.to(() => const EditAccountInformationView());
  }

  void _handleChangePassword() {
    Get.to(() => PrescriptionView());
  }

  void _handleNotificationSettings() {
    Get.to(() => const NotificationSettingsView());
  }

  void _handleClearSearchHistory() {
    ConfirmationDialog.show(
      title: 'Clear Search History',
      message: 'Do you want to clear your recent history?',
      successMessage: 'Your search history is cleared.✅',
      onConfirm: () => _settingsService.clearSearchHistory(),
      showSuccessMessage: true,
    );
  }

  void _handleClearSavedData() {
    ConfirmationDialog.show(
      title: 'Clear Saved Data',
      message: 'Do you want to clear your saved data?',
      successMessage: 'Your saved data is cleared.✅',
      onConfirm: () => _settingsService.clearSavedData(),
      showSuccessMessage: true,
    );
  }

  void _handleDeleteAccount() {
    Get.dialog(
      AccountDeletionDialog(
        onDelete:
            (reason, otherReason) =>
                _settingsService.deleteAccount(reason, otherReason),
      ),
    );
  }

  void _handleTermsOfUsage() {
    ReusablePopupDialog.show(
      context: Get.context!,
      title: 'Terms of Usage',
      sections: SettingsConstants.termsOfUsageSections,
      barrierDismissible: true,
      sectionBackgroundColor: SettingsConstants.sectionBackground,
      sectionSpacing: 16,
    );
  }

  void _handlePrivacyPolicy() {
    ReusablePopupDialog.show(
      context: Get.context!,
      title: 'Privacy Policy',
      sections: SettingsConstants.privacyPolicySections,
      barrierDismissible: true,
      sectionBackgroundColor: SettingsConstants.sectionBackground,
      sectionSpacing: 16,
    );
  }

  void _handleDisclaimer() {
    ReusablePopupDialog.show(
      context: Get.context!,
      title: 'Disclaimer',
      sections: SettingsConstants.disclaimerSections,
      barrierDismissible: true,
      sectionBackgroundColor: SettingsConstants.sectionBackground,
      sectionSpacing: 16,
    );
  }

  void _handleLogout() {
    ConfirmationDialog.show(
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      cancelText: 'Cancel',
      confirmText: 'Logout',
      confirmColor: Colors.red,
      onConfirm: () => _settingsService.logout(),
    );
  }
}
