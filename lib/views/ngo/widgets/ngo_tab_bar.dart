import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Pages/ngo_new_post.dart';

/// A reusable tab bar widget for 'New post' and 'Post History'
class NgoTabBar extends StatelessWidget {
  final NewPostViewModel controller;

  const NgoTabBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = Get.width;

    const activeColor = Color(0xFF6B79F5);
    const inactiveColor = Color(0xFF626262);

    return Obx(() => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => controller.selectedTab.value = 0,
          child: Container(
            width: 93,
            height: 39,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: controller.selectedTab.value == 0
                      ? activeColor
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              "New post",
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: w * 0.038,
                fontWeight: FontWeight.w600,
                color: controller.selectedTab.value == 0
                    ? activeColor
                    : inactiveColor.withOpacity(0.7),
                height: 1.2,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () => controller.selectedTab.value = 1,
          child: Container(
            width: 91,
            height: 39,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: controller.selectedTab.value == 1
                      ? activeColor
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              "Post History",
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: w * 0.038,
                fontWeight: FontWeight.w400,
                color: controller.selectedTab.value == 1
                    ? activeColor
                    : inactiveColor.withOpacity(0.7),
                height: 1.2,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
