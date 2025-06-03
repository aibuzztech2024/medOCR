import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/utils/methods/navigate_to.dart';
import 'package:avatar/viewModels/points/controller/points_tabbar_controller.dart';
import 'package:avatar/views/auth/select_role_view.dart';
import 'package:avatar/views/points/transaction_screen.dart';
import 'package:avatar/views/points/widget/reusable_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This widget serves as a container for the Advertisor tab bar,
class PointsTabbarContainer extends StatelessWidget {
  PointsTabbarContainer({super.key});

  final PointsTabbarController controller = Get.put(PointsTabbarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Points'),
        centerTitle: true,
        backgroundColor: LightThemeColors.scaffoldBackground,

        // Remove this it is just for showing the transaction screen
        // If you want to navigate to the transaction screen, you can keep this
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt),
            onPressed: () {
              navigateTo(() => TransactionScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        // Reactively rebuild if tabTitles changes
        return ReusableTabbar(
          // Pass the controller's tab titles and contents to the ReusableTabbar
          tabTitles: controller.tabTitles,
          tabContents: controller.tabContents,
        );
      }),
    );
  }
}
