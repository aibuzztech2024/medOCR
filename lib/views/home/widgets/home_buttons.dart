import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// Model representing each home button
class HomeButtonModel {
  final String title;
  final String iconPath;

  HomeButtonModel({required this.title, required this.iconPath});
}

/// ViewModel using GetX to manage button data and responsive sizes
class HomeButtonsController extends GetxController {
  // List of home buttons
  final buttons = <HomeButtonModel>[
    HomeButtonModel(title: "Buy", iconPath: "assets/icons/buy.svg"),
    HomeButtonModel(title: "Maps", iconPath: "assets/icons/map.svg"),
    HomeButtonModel(title: "Share", iconPath: "assets/icons/share.svg"),
    HomeButtonModel(title: "Points", iconPath: "assets/icons/points.svg"),
  ];

  // Responsive sizes
  late double buttonWidth;
  final double buttonHeight = 48;
  late double columnGap;
  late double rowGap;

  /// Initializes responsive values based on screen width
  void initResponsiveValues(double screenWidth) {
    columnGap = 12;
    rowGap = 16;

    // Force exactly 2 buttons per row with padding accounted for
    double horizontalPadding = 32; // 16 padding on left + right
    buttonWidth = (screenWidth - columnGap - horizontalPadding) / 2;
  }
}

/// HomeButtons widget (no Scaffold)
class HomeButtons extends StatelessWidget {
  const HomeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeButtonsController());
    final screenWidth = MediaQuery.of(context).size.width;
    controller.initResponsiveValues(screenWidth);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Wrap(
        spacing: controller.columnGap,
        runSpacing: controller.rowGap,
        children: controller.buttons.map((btn) {
          return GestureDetector(
            onTap: () {
              // TODO: Handle button tap here
            },
            child: Container(
              width: controller.buttonWidth,
              height: controller.buttonHeight,
              padding: const EdgeInsets.fromLTRB(6, 12, 12, 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFEF5E8),
                    Color(0xFFE3B673),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    btn.iconPath,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Colors.black87,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    btn.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                      letterSpacing: -0.5,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
