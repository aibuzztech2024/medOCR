import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/viewModels/advertisor/allrewards_tabbar_contoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// // Allrewards tabbar is the internal tabbar which switches to featured rewards / Popular coupons
class AllrewardsTabbar extends StatelessWidget {
  final List<String> tabTitles;
  final List<Widget> tabContents;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;

  final AllrewardsTabbarContoller controller;

  AllrewardsTabbar({
    super.key,
    required this.tabTitles,
    required this.tabContents,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
    AllrewardsTabbarContoller? controller,
  }) : assert(
         tabTitles.length == tabContents.length,
         'Tab titles and contents must have the same length',
       ),
       controller = controller ?? Get.put(AllrewardsTabbarContoller());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //internal tabbar
        _buildTabBar(),

        //tabbar contents
        Obx(() => Expanded(child: tabContents[controller.activeIndex.value])),
      ],
    );
  }

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

  Widget _buildTabItem(String title, int index) {
    return Obx(() {
      bool isActive = controller.activeIndex.value == index;
      return Expanded(
        child: InkWell(
          onTap: () => controller.changeTab(index),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    });
  }
}
