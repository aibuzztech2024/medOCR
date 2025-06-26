import 'package:avatar/core/constants/icons_paths.dart';
import 'package:avatar/core/constants/image_paths.dart';
import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/themes/light/light_theme_data.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/models/navigation/segment_tab_model.dart';
import 'package:avatar/viewModels/hospital/order_history_controller.dart';
import 'package:avatar/viewModels/navigation/bottom_nav_controller.dart';
import 'package:avatar/views/auth/login/login_view.dart';
import 'package:avatar/views/hospital/Widgets/endcustomerhome/widgets/upcoming_events_widget.dart';
import 'package:avatar/views/hospital/Widgets/donut_chart.dart';
import 'package:avatar/views/hospital/Widgets/order_history_view.dart';
import 'package:avatar/views/hospital/Widgets/prescription_view.dart';
import 'package:avatar/views/hospital/Widgets/faq_View.dart';
import 'package:avatar/views/hospital/Widgets/hospital_place_list.dart';
import 'package:avatar/views/hospital/Widgets/newticket.dart';
import 'package:avatar/views/navigation/bottom_nav_bar.dart';
import 'package:avatar/views/navigation/tab.dart';
import 'package:avatar/widgets/cards/order_history_card.dart';
import 'package:avatar/views/navigation/perfect_segment_toggle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'models/navigation/bottom_nav_item_model.dart';
import 'viewModels/hospital/donut_chart_controller.dart';

/// This is the starting point of the application
void main() {
  // Ensure that the Flutter engine is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(BottomNavController());

  // Initialize SegmentTabController
  // Run the application with the MyApp widget
  runApp(MyApp());
}

/// MyApp is the main widget of the application
class MyApp extends StatelessWidget {
  MyApp({super.key});
  final OrderHistoryController f = Get.put(OrderHistoryController());

  @override
  Widget build(BuildContext context) {
    // Define segment tabs data with content widgets
    final List<SegmentTabModel> tabs = [
      SegmentTabModel(
        label: 'Prescription',
        iconSvgPath: "assets/icons/medical-prescription_svgrepo.com.svg",
        activeColor: LightThemeColors.buttoncolors,
        child: NewTicketPage(),
      ),
      SegmentTabModel(
        label: 'Bills',
        iconSvgPath: "assets/icons/document-text_svgrepo.com.svg",
        activeColor: LightThemeColors.buttoncolors,
        child: OrderHistoryView(controller: f),
      ),
      SegmentTabModel(
        label: 'Medicine',
        iconSvgPath: "assets/icons/medicine-pills-tablets_svgrepo.com.svg",
        activeColor: LightThemeColors.buttoncolors,
        child:UpcomingEventsWidget(),
      ),
    ];

    // Get the SegmentTabController and set its tabs

    // Define navigation items for BottomNavBar
    final navItems = [
      BottomNavItemModel(
        icon: IconsPaths.home,
        title: "Home",
        screen: Center(child: LoginView()),
      ),
      BottomNavItemModel(
        icon: IconsPaths.mapSearch,
        title: "Map",
        screen: PerfectSegmentToggleWidget(tabs: tabs),
      ),
      BottomNavItemModel(
        icon: IconsPaths.upload,
        title: "Post",
        screen: PrescriptionView(),
      ),
      BottomNavItemModel(
        icon: IconsPaths.purchase,
        title: "Purchase",
        screen: Center(child: DonutChartWidget()),
      ),
      BottomNavItemModel(
        icon: IconsPaths.home,
        // Using home icon as a placeholder
        title: "Profile",
        screen: Center(child: AppText.heading("Profile", fontSize: 24)),
        isCustomIcon: true,
        customIcon: CircleAvatar(
          radius: 14,
          backgroundImage: AssetImage(ImagePaths.profileImage),
        ),
      ),
    ];

    // Use GetMaterialApp to enable GetX features
    return GetMaterialApp(
      // Hides the debugBanner in Debug Mode
      debugShowCheckedModeBanner: false,
      title: 'Avatar',
      // Sets the theme of the application to [lightThemeData]
      theme: lightThemeData,
      // TODO: Check if user is Logged-In,
      // If user is logged in, navigate to h,,,,,,,,,,ome page,
      // If user is not logged in, navigate to select role page
      //home: SelectRoleView(),
      home: PrescriptionView(),
    );
  }
}
