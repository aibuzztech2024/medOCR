import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../../viewModels/map/bottom_nav_controller.dart';
import 'hospital_place_list.dart';
import 'referral_card_widget.dart';

/// Main navigation with Home, Map, Post, Purchase, and Profile tabs

class BottomNavBar extends StatelessWidget {
  final BottomNavController navController = Get.put(BottomNavController());

  Widget _buildSvgIcon(String assetPath, bool isSelected) {
    return SvgPicture.asset(
      assetPath,
      colorFilter: ColorFilter.mode(
        isSelected ? Colors.orange : Colors.grey,
        //TODO: todo to change color nav
        BlendMode.srcIn,
      ),
    );
  }

  // TODO: Replace placeholder screens with actual content

  // Custom SVG icon that changes color based on state
  // Define data for each tab
  final List<Map<String, dynamic>> _tabData = [
    {
      'icon': 'assets/icons/home.svg',
      'title': "Home",
      'screen': Center(
        child: Text(
          "Home",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    },
    {
      'icon': 'assets/icons/map_search.svg',
      'title': "Map",
      'screen': Center(
        child: Text(
          "Map",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    },
    {
      'icon': 'assets/icons/upload.svg',
      'title': "Post",
      'screen': Center(child: HospitalPlaceList()),
    },
    {
      'icon': 'assets/icons/purchase.svg',
      'title': "Purchase",
      'screen': Center(child: ReferralCard()),
    },
    {
      'icon': CircleAvatar(
        radius: 14,
        backgroundImage: AssetImage("assets/images/profile.png"),
      ),
      'title': "Profile",
      'screen': Center(
        child: Text(
          "Profile",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    },
  ];

  List<PersistentTabConfig> _navBarItems() {
    return _tabData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      return PersistentTabConfig(
        screen: data['screen'] as Widget,
        item: ItemConfig(
          icon:
              data['icon'] is String
                  ? Obx(
                    () => _buildSvgIcon(
                      data['icon'] as String,
                      navController.currentIndex.value == index,
                    ),
                  )
                  : data['icon'] as Widget,
          title: data['title'] as String,
          activeForegroundColor: Colors.orange, //TODO: todo to change color nav
          inactiveForegroundColor: Colors.grey, //TODO: todo to change color nav
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
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.0, -1.0),
                ),
              ],
              color: Colors.white.withValues(alpha: 0.95),
            ),
          ),
      onTabChanged: navController.changeTab,
    );
  }
}
