import 'package:avatar/core/themes/light/light_theme_data.dart';
import 'package:avatar/viewModels/donate/campaign_view_model.dart';
import 'package:avatar/views/donate/Pages/donate_page.dart';
import 'package:avatar/views/pharmacy/Pages/order_discussions.dart';
import 'package:avatar/views/pharmacy/Pages/share_history.dart';
import 'package:avatar/views/pharmacy/widgets/bill_card.dart';
import 'package:avatar/views/pharmacy/widgets/chat_list_widget.dart';
import 'package:avatar/views/pharmacy/widgets/search_bar_widget.dart';
import 'package:avatar/views/pharmacy/widgets/share_bill_textfield.dart';
import 'package:avatar/views/pharmacy/widgets/submit_request.dart';
import 'package:avatar/views/pharmacy/Pages/full_order_history.dart';
import 'package:avatar/views/pharmacy/widgets/transaction_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'core/widgets/app_text.dart';

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
      home: OrderDiscussions(),
    );
  }
}
