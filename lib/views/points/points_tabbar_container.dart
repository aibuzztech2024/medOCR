import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/utils/methods/navigate_to.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/points/controller/points_tabbar_controller.dart';
import 'package:avatar/views/endcustomer/widget/upcoming_events_widget.dart';
import 'package:avatar/views/earnings/earnings_screen.dart';
import 'package:avatar/views/map/widgets/trip_completion_dialog.dart';
import 'package:avatar/views/points/transaction_screen.dart';
import 'package:avatar/views/points/widget/reusable_tabbar.dart';
import 'package:avatar/views/endcustomer/end_customer_homescreen.dart';
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
        title: AppText.heading(
          'Points',
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: context.theme.scaffoldBackgroundColor,

        //  TODO Remove this iconButtons it is just for showing the different screen
        actions: [
          IconButton(
            icon: const Icon(
              Icons.local_offer_outlined,
              color: Color(0xFFF79E1B),
            ),
            onPressed: () {
              navigateTo(() => TripCompletionDialog());
            },
          ),
          IconButton(
            icon: const Icon(Icons.paid_outlined, color: Color(0xFFF79E1B)),
            onPressed: () {
              navigateTo(() => EarningsScreen());
            },
          ),
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
          color: LightThemeColors.pharmacyColor,
          tabTitles: controller.tabTitles.toList(),
          tabContents: controller.tabContents.toList(),
        );
      }),
    );
  }
}
