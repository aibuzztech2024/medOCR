import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar/views/enduser_phone_settings/edit_avatar_viewmodel.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/profile_image.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/custom_navbar.dart';

// View - Main page UI
class AvatarSelectionPage extends StatelessWidget {
  final AvatarController controller = Get.put(AvatarController());

  AvatarSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // First Section - Main display image with header
          Expanded(
            flex: 374,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(255, 218, 164, 1), // rgba(255, 218, 164, 1)
                    Color.fromRGBO(
                      247,
                      158,
                      27,
                      0.61,
                    ), // rgba(247, 158, 27, 0.61)
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  // Header with back button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black87,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Change Avatar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  // Main display image - Direct implementation without ProfileImageWidget
                  Expanded(
                    child: Center(
                      child: Obx(
                        () => Container(
                          width: 200,
                          height: 200,
                          child:
                              controller.mainDisplayImage.value.isNotEmpty
                                  ? Image.asset(
                                    controller.mainDisplayImage.value,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 200,
                                        height: 200,
                                        color: Colors.grey[200],
                                        child: Icon(
                                          Icons.person,
                                          size: 80,
                                          color: Colors.grey[600],
                                        ),
                                      );
                                    },
                                  )
                                  : Container(
                                    width: 200,
                                    height: 200,
                                    color: Colors.grey[200],
                                    child: Icon(
                                      Icons.person,
                                      size: 80,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Second Section - Avatar selection using ProfileImageWidget
          Expanded(
            flex: 500,
            child: Container(
              color: Colors.grey.shade50,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Column(
                children: [
                  // Six ProfileImageWidgets in a 2x3 grid
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        // First row - 3 avatars
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(3, (index) {
                            return Obx(
                              () => ProfileImageWidget(
                                imageUrl: controller.avatarImages[index],
                                size: 100,
                                showEditButton: false,
                                enableClickEffect: true,
                                isSelected:
                                    controller.selectedAvatarIndex.value ==
                                    index,
                                onTap: () => controller.selectAvatar(index),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 20),
                        // Second row - 3 avatars
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(3, (index) {
                            int avatarIndex =
                                index + 3; // Offset for second row
                            // Check if avatarIndex is within bounds
                            if (avatarIndex < controller.avatarImages.length) {
                              return Obx(
                                () => ProfileImageWidget(
                                  imageUrl:
                                      controller.avatarImages[avatarIndex],
                                  size: 100,
                                  showEditButton: false,
                                  enableClickEffect: true,
                                  isSelected:
                                      controller.selectedAvatarIndex.value ==
                                      avatarIndex,
                                  onTap:
                                      () =>
                                          controller.selectAvatar(avatarIndex),
                                ),
                              );
                            } else {
                              // Return empty container if index is out of bounds
                              return Container(width: 100, height: 100);
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        cancelText: 'Cancel',
        submitText: 'Change',
        onCancel: controller.cancelChanges,
        onSubmit: controller.saveChanges,
      ),
    );
  }
}
