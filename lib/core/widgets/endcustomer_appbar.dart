import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/endcustomerhome/controller/end_customer_appbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A custom app bar that shows user greeting, location, weather, notifications, cart, and profile info.
/// This widget relies on `EndCustomerAppbarController` for reactive state management using GetX.
class EndcustomerAppbar extends StatelessWidget implements PreferredSizeWidget {
  final EndCustomerAppbarController controller =
      Get.find<EndCustomerAppbarController>();

  EndcustomerAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false, // avoid padding below for compact layout
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Expanded(child: _buildUserInfo()), _buildActions()],
        ),
      ),
    );
  }

  /// Displays greeting, date, location, and weather info
  Widget _buildUserInfo() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Greeting + Date
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Hi ${controller.userName.value}, ',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                TextSpan(
                  text: controller.currentDate.value,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // Location + Weather
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.black87),
              const SizedBox(width: 4),
              AppText.caption(
                controller.location.value,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(width: 16),
              AppText.caption(
                controller.weather.value,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Displays action icons: Cart, Notifications (with badge), Profile
  Widget _buildActions() {
    return Row(
      children: [
        // 🛒 Cart icon
        InkWell(
          onTap: controller.onCartTapped,
          borderRadius: BorderRadius.circular(20),
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 24,
              color: Colors.black87,
            ),
          ),
        ),

        const SizedBox(width: 8),

        // 🔔 Notification icon with badge
        _buildIconWithBadge(
          icon: Icons.notifications_none_rounded,
          onTap: controller.onNotificationTapped,
          countRx: controller.notificationCount,
        ),

        const SizedBox(width: 8),

        // 👤 Profile avatar
        _buildProfileAvatar(),
      ],
    );
  }

  /// Builds an icon with a badge for count notifications
  Widget _buildIconWithBadge({
    required IconData icon,
    required VoidCallback onTap,
    required RxInt countRx,
  }) {
    return Obx(() {
      final count = countRx.value;

      return Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(icon, size: 24, color: Colors.black87),
            ),
          ),

          // Red badge
          if (count > 0)
            Positioned(
              right: 2,
              top: 2,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      );
    });
  }

  /// Builds profile avatar that is tappable
  Widget _buildProfileAvatar() {
    return Obx(() {
      final imagePath = controller.profileImagePath.value;

      return InkWell(
        onTap: controller.onProfileTapped,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: ClipOval(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.person,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16);
}
