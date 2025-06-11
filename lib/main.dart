import 'package:avatar/core/themes/light/light_theme_data.dart';
import 'package:avatar/viewModels/donate/campaign_view_model.dart';
import 'package:avatar/views/donate/widgets/campaign_card_view.dart';
import 'package:avatar/views/donate/Pages/campaign_details_page.dart';
import 'package:avatar/views/donate/Pages/donate_page.dart';
import 'package:avatar/views/donate/widgets/recent_donation_card.dart';
import 'package:avatar/views/help/ticket_history_page.dart';
import 'package:avatar/views/home/widgets/overview_page.dart';
import 'package:avatar/views/map/map_scree_view.dart';
import 'package:avatar/views/purchase/widgets/card_page.dart';
import 'package:avatar/views/purchase/widgets/submit_request.dart';
import 'package:avatar/views/purchase/widgets/transaction_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

/// This is the starting point of the application
void main() {
  Get.put(CampaignViewModel());
  // Ensure that the Flutter engine is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  // Run the application with the MyApp widget
  runApp(const MyApp());
}

/// MyApp is the main widget of the application`
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
      // TODO: Check if user is Logged-In
      // If user is logged in, navigate to home page
      // If user is not logged in, navigate to select role page
      //home: SelectRoleView(),
      home: DonatePage(),

    );
  }
}
