import 'package:avatar/core/themes/light/light_theme_data.dart';
import 'package:avatar/core/widgets/sample_page.dart';
import 'package:avatar/viewModels/navigation/bottom_nav_controller.dart';
import 'package:avatar/views/auth/select_role_view.dart';
import 'package:avatar/views/enduser_phone_settings/phone_settings_view.dart';
import 'package:avatar/views/hospital/prescription_view.dart';
import 'package:avatar/views/pharmacy_app/purchase/order_discussion.dart';
import 'package:avatar/views/pharmacy_app/purchase/purchase_details.dart';
import 'package:avatar/widgets/bottom_navbar_end_customer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This is the starting point of the application
void main() {
  // Ensure that the Flutter engine is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(BottomNavController());
  // Initialize SegmentTabController
  // Run the application with the MyApp widget
  runApp(const MyApp());
}

/// MyApp is the main widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      home: BottomNavbarEndCustomer(),
    );
  }
}
