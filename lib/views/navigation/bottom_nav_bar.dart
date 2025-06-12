import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../core/themes/light/light_theme_colors.dart';
import '../../models/navigation/bottom_nav_item_model.dart';
import '../../viewModels/navigation/bottom_nav_controller.dart';

/// Main navigation with Home, Map, Post, Purchase, and Profile tabs

class BottomNavBar extends StatelessWidget {
  final List<BottomNavItemModel> navItems;
  final BottomNavController navController;

  BottomNavBar({
    Key? key,
    required this.navItems,
    BottomNavController? controller,
  }) : navController = controller ?? Get.put(BottomNavController()),
       super(key: key) {
    navController.setNavItems(navItems);
  }

  Widget _buildSvgIcon(String assetPath, bool isSelected) {
    return SvgPicture.asset(
      assetPath,
      colorFilter: ColorFilter.mode(
        isSelected
            ? LightThemeColors.orangeicon
            : LightThemeColors.subtitleText,
        BlendMode.srcIn,
      ),
    );
  }

  // TODO: Replace placeholder screens with actual content

  // Custom SVG icon that changes color based on state
  // Define data for each tab

  List<PersistentTabConfig> _navBarItems() {
    return navItems.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      Widget baseIconWidget =
          item.isCustomIcon
              ? item.customIcon!
              : Obx(
                () => _buildSvgIcon(
                  item.icon,
                  navController.currentIndex.value == index,
                ),
              );

      return PersistentTabConfig(
        screen: item.screen,
        item: ItemConfig(
          icon:
              item.child != null
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [baseIconWidget, SizedBox(width: 8), item.child!],
                  )
                  : baseIconWidget,
          title: item.child != null ? null : item.title,
          activeForegroundColor: LightThemeColors.orangeicon,
          inactiveForegroundColor: LightThemeColors.subtitleText,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: _navBarItems(),
      controller: PersistentTabController(
        initialIndex: navController.currentIndex.value,
      ),
      navBarBuilder:
          (navBarConfig) => Style6BottomNavBar(
            navBarConfig: navBarConfig,
            navBarDecoration: NavBarDecoration(
              boxShadow: [
                BoxShadow(
                  color: LightThemeColors.subtitleText.withOpacity(0.1),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.0, -1.0),
                ),
              ],
              color: LightThemeColors.scaffoldBackground.withOpacity(0.95),
            ),
          ),
      onTabChanged: navController.changeTab,
      // TODO: Handle additional functionalities like notifications or settings
      // TODO: Implement logic for deep linking or specific tab actions
    );
  }
}
