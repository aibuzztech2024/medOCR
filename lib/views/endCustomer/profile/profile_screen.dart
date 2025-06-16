// lib/screens/profile_screen.dart
import 'package:avatar/core/constants/icons_paths.dart';
import 'package:avatar/core/constants/image_paths.dart';
import 'package:avatar/views/endCustomer/home/widgets/profile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileHeader(
                  name: 'Monica',
                  userType: 'End User',
                  imageUrl: ImagePaths.userProfile, // sample image
                ),
                const SizedBox(height: 16),
                const BadgeCard(),
                const SizedBox(height: 16),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      spacing: 8,
                      children: [
                        MenuItem(
                          icon: Icons.bookmark_border_outlined,
                          title: 'Saved Item',
                          color: Colors.orange,
                          onPressed: () => Get.snackbar("","saved items", snackPosition: SnackPosition.BOTTOM),
                        ),
                        MenuItem(
                          icon: Icons.share_outlined,
                          title: 'Referral',
                          onPressed: () => Get.snackbar("","referral tapped", snackPosition: SnackPosition.BOTTOM),
                        ),
                        MenuItem(svgPath: IconsPaths.donate, title: 'Donate', onPressed: ()=> Get.snackbar("","Donate tapped", snackPosition: SnackPosition.BOTTOM),
                        ),
                        MenuItem(svgPath: IconsPaths.setting, title: 'Settings', onPressed: () => Get.snackbar("","Setting tapped", snackPosition: SnackPosition.BOTTOM),
                        ),
                        MenuItem(svgPath: IconsPaths.support, title: 'Support', onPressed: () => Get.snackbar("","Support tapped", snackPosition: SnackPosition.BOTTOM),
                        ),
                        MenuItem(svgPath: IconsPaths.logout, title: 'Logout', onPressed: ()=> Get.snackbar("","referral tapped", snackPosition: SnackPosition.BOTTOM),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
