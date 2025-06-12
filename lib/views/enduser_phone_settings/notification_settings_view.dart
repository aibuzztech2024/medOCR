import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/checkbox_settings_card.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/labeled_text_button.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/toggle_setting_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import the ViewModel
import 'notification_settings_viewmodel.dart';

/// Notification Settings View following MVVM architecture with GetX
class NotificationSettingsView extends StatelessWidget {
  const NotificationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ViewModel using GetX dependency injection
    final NotificationSettingsViewModel viewModel = Get.put(
      NotificationSettingsViewModel(),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Notification Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Channel Management Section
            AppText(
              'Notification Channel Management',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),

            // In-App Notifications Toggle - Reactive UI
            Obx(
              () => ToggleSettingCard.withSvg(
                svgAsset:
                    'assets/icons/settings_section/notification_page/in_app_notification_icon.svg',
                title: 'In-App Notifications',
                initialValue: viewModel.inAppNotifications,
                onChanged: viewModel.toggleInAppNotifications,
              ),
            ),

            // Email Notifications Toggle - Reactive UI
            Obx(
              () => ToggleSettingCard.withSvg(
                svgAsset:
                    'assets/icons/settings_section/notification_page/email_notification_icon.svg',
                title: 'Email Notification',
                initialValue: viewModel.emailNotifications,
                onChanged: viewModel.toggleEmailNotifications,
              ),
            ),

            // Push Notifications Toggle - Reactive UI
            Obx(
              () => ToggleSettingCard.withSvg(
                svgAsset:
                    'assets/icons/settings_section/notification_page/push_notification_icon.svg',
                title: 'Push Notification',
                initialValue: viewModel.pushNotifications,
                onChanged: viewModel.togglePushNotifications,
              ),
            ),

            const SizedBox(height: 16),

            // Priority Level Management Section
            AppText(
              'Priority Level Management',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),

            // Priority Level Checkboxes - Now fully reactive with ViewModel
            Obx(
              () => CheckboxSettingsWidget(
                menuItems: viewModel.checkboxMenuItems,
              ),
            ),

            const SizedBox(height: 16),

            // Quiet Hours Settings Section
            AppText(
              'Quiet Hours Settings',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),

            // Quiet Hours Time Selection - Static implementation to avoid crashes
            LabeledTextDisplay(
              value: "Start Quiet Mode",
              height: 60.0,
              valueStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              trailingWidgets: [
                // Start Time Button
                OutlinedButton(
                  onPressed: viewModel.onStartQuietTimePressed,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    minimumSize: Size(0, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Start Time',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                    ],
                  ),
                ),

                // End Time Button
                OutlinedButton(
                  onPressed: viewModel.onEndQuietTimePressed,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    minimumSize: Size(0, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'End Time',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Icon(Icons.access_time, size: 16, color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
