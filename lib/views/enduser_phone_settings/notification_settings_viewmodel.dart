import 'package:avatar/views/enduser_phone_settings/widgets/checkbox_settings_card.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// ViewModel for managing notification settings state and business logic
class NotificationSettingsViewModel extends GetxController {
  // Observable variables for notification channel toggles
  final _inAppNotifications = true.obs;
  final _emailNotifications = true.obs;
  final _pushNotifications = true.obs;

  // Observable variables for priority level checkboxes
  final _regulatoryAlerts = true.obs;
  final _promotionsOffers = true.obs;

  // Observable variables for quiet hours
  final _startQuietTime = "".obs;
  final _endQuietTime = "".obs;

  // Getters for reactive UI binding
  bool get inAppNotifications => _inAppNotifications.value;
  bool get emailNotifications => _emailNotifications.value;
  bool get pushNotifications => _pushNotifications.value;
  bool get regulatoryAlerts => _regulatoryAlerts.value;
  bool get promotionsOffers => _promotionsOffers.value;
  String get startQuietTime => _startQuietTime.value;
  String get endQuietTime => _endQuietTime.value;

  /// Toggle in-app notifications on/off
  void toggleInAppNotifications(bool value) {
    _inAppNotifications.value = value;
    // TODO: Implement actual notification channel update logic
  }

  /// Toggle email notifications on/off
  void toggleEmailNotifications(bool value) {
    _emailNotifications.value = value;
    // TODO: Implement actual email notification settings update
  }

  /// Toggle push notifications on/off
  void togglePushNotifications(bool value) {
    _pushNotifications.value = value;
    // TODO: Implement actual push notification settings update
  }

  /// Toggle regulatory alerts checkbox
  void toggleRegulatoryAlerts() {
    _regulatoryAlerts.toggle();
    // TODO: Implement actual regulatory alerts priority update
  }

  /// Toggle promotions & offers checkbox
  void togglePromotionsOffers() {
    _promotionsOffers.toggle();
    // TODO: Implement actual promotions settings update
  }

  /// Get checkbox menu items for reactive UI
  List<CheckboxMenuItemModel> get checkboxMenuItems => [
    CheckboxMenuItemModel(
      svgAsset:
          'assets/icons/settings_section/notification_page/regulatory_alert_icon.svg',
      title: 'Regulatory Alerts',
      isChecked: _regulatoryAlerts.value,
      onChanged: toggleRegulatoryAlerts,
    ),
    CheckboxMenuItemModel(
      svgAsset:
          'assets/icons/settings_section/notification_page/promotion_and_offers_icon.svg',
      title: 'Promotions & Offers',
      isChecked: _promotionsOffers.value,
      onChanged: togglePromotionsOffers,
    ),
  ];

  /// Handle start quiet time selection
  void onStartQuietTimePressed() {
    // TODO: Implement time picker for start quiet time
    // This should open a time picker dialog and update _startQuietTime
  }

  /// Handle end quiet time selection
  void onEndQuietTimePressed() {
    // TODO: Implement time picker for end quiet time
    // This should open a time picker dialog and update _endQuietTime
  }

  /// Initialize default values or load from storage
  @override
  void onInit() {
    super.onInit();
    // TODO: Load saved notification settings from storage/API
    _loadNotificationSettings();
  }

  /// Load notification settings from storage or API
  void _loadNotificationSettings() {
    // TODO: Implement loading settings from SharedPreferences or API
  }

  /// Save notification settings to storage or API
  void _saveNotificationSettings() {
    // TODO: Implement saving settings to SharedPreferences or API
  }
}
