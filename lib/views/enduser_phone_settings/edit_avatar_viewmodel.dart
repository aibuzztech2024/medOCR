import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controller (ViewModel) - Handles business logic and state management
class AvatarController extends GetxController {
  // Observable for currently selected avatar index
  var selectedAvatarIndex = 0.obs;
  // Observable for the main display image
  var mainDisplayImage = ''.obs;
  // List of available avatar images
  final List<String> avatarImages = [
    'assets/images/character_1.png',
    'assets/images/character_2.png',
    'assets/images/character_3.png',
    'assets/images/character_4.png',
    'assets/images/character_5.png',
    'assets/images/character_6.png',
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize main display image with the first avatar
    mainDisplayImage.value = avatarImages[0];
    // Set the first avatar as selected by default
    selectedAvatarIndex.value = 0;
  }

  // Method to handle avatar selection
  void selectAvatar(int index) {
    if (index >= 0 && index < avatarImages.length) {
      selectedAvatarIndex.value = index;
      mainDisplayImage.value = avatarImages[index];
    }
  }

  // Method to save changes
  void saveChanges() {
    Get.snackbar(
      'Avatar Updated',
      'Your avatar has been changed successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
    Get.back();
  }

  // Method to handle cancel action
  void cancelChanges() {
    Get.back();
  }
}
