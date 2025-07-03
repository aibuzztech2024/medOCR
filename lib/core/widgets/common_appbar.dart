import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showNotification;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onBackPress;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? iconColor;
  final double? elevation;
  final bool showBackButton;

  const CommonAppbar({
    super.key,
    required this.title,
    this.showNotification = false,
    this.onNotificationTap,
    this.onBackPress,
    this.backgroundColor,
    this.titleColor,
    this.iconColor,
    this.elevation = 0,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: backgroundColor ?? Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 8, // Horizontal padding from left
      leading:
          showBackButton
              ? Padding(
                padding: const EdgeInsets.only(left: 0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: iconColor ?? Colors.black,
                    size: 24,
                  ),
                  onPressed: onBackPress ?? () => Get.back(),
                ),
              )
              : null,
      title: AppText.heading(
        title,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: titleColor ?? Colors.black,
      ),
      centerTitle: false,
      actions: [
        if (showNotification) ...[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: iconColor ?? Colors.black,
                    size: 24,
                  ),
                  onPressed: onNotificationTap ?? _handleNotificationTap,
                ),
              ],
            ),
          ),
        ],
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: GestureDetector(
            onTap: _handleProfileTap,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/gpt_blue.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleNotificationTap() {
    Get.snackbar(
      'Notifications',
      'Opening notifications...',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }

  void _handleProfileTap() {
    Get.snackbar(
      'Profile',
      'Opening profile...',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
