// profile_tile.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// --- MODEL CLASS ---
/// Represents one profile/message row.
class ProfileModel {
  final String name;
  final String time;      // e.g. "12:30 PM"
  final String title;     // e.g. "Crocin 1 Strip"
  final String subtitle;  // e.g. "New Bid Request"

  ProfileModel({
    required this.name,
    required this.time,
    required this.title,
    required this.subtitle,
  });
}

/// --- VIEWMODEL CLASS ---
/// Holds a reactive list of profiles.
class ProfileViewModel extends GetxController {
  final profiles = <ProfileModel>[
    ProfileModel(
      name: 'Monika Singh',
      time: '12:30 PM',
      title: 'Crocin 1 Strip',
      subtitle: 'New Bid Request',
    ),
    // Add or fetch more items dynamically…
  ].obs;
}

/// --- PROFILE LIST COMPONENT ---
/// Can be used inside any parent widget.
class ProfileTileList extends StatelessWidget {
  final ProfileViewModel vm = Get.put(ProfileViewModel());

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;

    // Responsive font sizes relative to width
    double fontSizeName = width * 0.04;
    double fontSizeTime = width * 0.035;
    double fontSizeSubtitle = width * 0.035;
    double avatarSize = width * 0.12;
    double avatarPadding = avatarSize * 0.2;

    return Obx(() => ListView.builder(
      shrinkWrap: true,           // Use this if inside a scrollable parent
      physics: NeverScrollableScrollPhysics(), // Disable inner scrolling if needed
      itemCount: vm.profiles.length,
      itemBuilder: (context, index) {
        final profile = vm.profiles[index];

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.01,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with initials
              Container(
                width: avatarSize,
                height: avatarSize,
                padding: EdgeInsets.all(avatarPadding),
                decoration: BoxDecoration(
                  color: const Color(0x4D3AAFA9),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      _initials(profile.name),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSizeName * 0.9,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: width * 0.035),

              // Text block with name, time, title, subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + Time Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            profile.name,
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: fontSizeName,
                              height: 1.2,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        Text(
                          profile.time,
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: fontSizeTime,
                            height: 1.2,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.004),

                    // Title • Subtitle Text
                    Text(
                      '${profile.title} • ${profile.subtitle}',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: fontSizeSubtitle,
                        height: 1.2,
                        color: const Color(0xFF929292),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ));
  }

  /// Returns initials from a full name (“Monika Singh” → “MS”)
  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
  }
}
