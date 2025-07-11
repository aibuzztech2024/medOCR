
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controller for managing AppBar state
class AdvertisorAppbarController extends GetxController {
  // You can add any state management logic here
  void onNewPostPressed() {
    // Handle new post action
    Get.snackbar(
      'New Post',
      'New post button pressed',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void onGlobePressed() {
    // Handle globe/world action
    Get.snackbar(
      'Globe',
      'Globe button pressed',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  void onShoppingCartPressed() {
    // Handle shopping cart action
    Get.snackbar(
      'Shopping Cart',
      'Shopping cart button pressed',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  void onNotificationPressed() {
    // Handle notification action
    Get.snackbar(
      'Notifications',
      'Notification button pressed',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}