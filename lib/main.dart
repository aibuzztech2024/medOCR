import 'package:avatar/core/themes/light/light_theme_data.dart';
import 'package:avatar/views/map/map_scree_view.dart';
import 'package:avatar/views/map/widgets/route_draggable.dart';
import 'package:avatar/views/share/calender.dart';
import 'package:avatar/views/share/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'viewModels/map/route_draggable.dart';

/// This is the starting point of the application
void main() {
  // Ensure that the Flutter engine is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  // Run the application with the MyApp widget
  runApp(const MyApp());
}

/// MyApp is the main widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RouteDraggableController());
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
      home: RouteDraggable(),
    );
  }
}
