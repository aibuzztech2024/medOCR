import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  static void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xFFDC3545),
      colorText: Colors.white,
      margin: EdgeInsets.all(12),
      duration: Duration(seconds: 2),
    );
  }

  static void showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.black,
      margin: EdgeInsets.all(12),
      duration: Duration(seconds: 2),
    );
  }

  static void showInfo(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.shade100,
      colorText: Colors.black,
      margin: EdgeInsets.all(12),
      duration: Duration(seconds: 2),
    );
  }
}
