import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/viewModels/points/controller/allrewards_tabbar_controller.dart';

/// Internal tabbar widget that switches between Featured Rewards and Popular Coupons.
/// Uses GetX controller to manage active tab state.
class AllrewardsTabbar extends StatelessWidget {
  final List<String> tabTitles;
  final List<Widget> tabContents;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;

  /// Tab controller (GetX)
  final AllRewardsTabbarController controller;

  AllrewardsTabbar({
    super.key,
    required this.tabTitles,
    required this.tabContents,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
    AllRewardsTabbarController? controller,
  }) : assert(
         tabTitles.length == tabContents.length,
         'Tab titles and contents must have the same length',
       ),
       controller = controller ?? Get.put(AllRewardsTabbarController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Internal tabbar buttons
        _buildTabBar(),

        // Tab contents that reactively change based on selected tab
        Obx(
          () => Expanded(
            child: IndexedStack(
              index: controller.activeIndex.value,
              children: tabContents,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the tab bar with each tab button
  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor ?? Colors.grey[100],
      ),
      child: Row(
        children: List.generate(
          tabTitles.length,
          (index) => _buildTabItem(tabTitles[index], index),
        ),
      ),
    );
  }

  /// Builds a single tab item (button)
  Widget _buildTabItem(String title, int index) {
    return Obx(() {
      final isActive = controller.activeIndex.value == index;
      return Expanded(
        child: InkWell(
          onTap: () => controller.changeTab(index),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color:
                  isActive
                      ? (activeColor ?? LightThemeColors.advertisorColor)
                      : LightThemeColors.inputFill,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color:
                    isActive ? Colors.white : (inactiveColor ?? Colors.black87),
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    });
  }
}
