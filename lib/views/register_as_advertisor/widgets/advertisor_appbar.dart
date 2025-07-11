import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/register_advisor/advertisor_appbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvertisorAppbar extends StatelessWidget {
  final String? title;
  final VoidCallback? onNewPostPressed;
  final VoidCallback? onGlobePressed;
  final VoidCallback? onShoppingCartPressed;
  final VoidCallback? onNotificationPressed;
  final Color backgroundColor;
  final double height;

  const AdvertisorAppbar({
    super.key,
    this.title,
    this.onNewPostPressed,
    this.onGlobePressed,
    this.onShoppingCartPressed,
    this.onNotificationPressed,
    this.backgroundColor = Colors.white,
    this.height = 60.0,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdvertisorAppbarController());

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // New Post Button
          ElevatedButton.icon(
            onPressed: onNewPostPressed ?? controller.onNewPostPressed,
            icon: const Icon(Icons.add, color: Colors.white, size: 24),
            label: AppText.heading(
              'New Post',
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),

            style: ElevatedButton.styleFrom(
              backgroundColor: LightThemeColors.advertisorColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),

          const Spacer(), // Push icons to the right
          // Right side icons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Globe/World Icon
              GestureDetector(
                onTap: onGlobePressed ?? controller.onGlobePressed,
                child: Image.asset(
                  'assets/images/gpt_blue.png',
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 24),

              // Shopping Cart Icon
              GestureDetector(
                onTap:
                    onShoppingCartPressed ?? controller.onShoppingCartPressed,
                child: Image.asset(
                  'assets/images/shopping_cart.png',
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 24),

              // Notification Bell Icon
              GestureDetector(
                onTap:
                    onNotificationPressed ?? controller.onNotificationPressed,
                child: Image.asset(
                  'assets/images/bell.png',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
