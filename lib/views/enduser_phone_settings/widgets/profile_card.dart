import 'package:avatar/views/enduser_phone_settings/edit_profilel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCardWidget extends StatelessWidget {
  final String name;
  final String email;
  final String? profileImageUrl;
  final VoidCallback? onEditPressed;

  const ProfileCardWidget({
    Key? key,
    required this.name,
    required this.email,
    this.profileImageUrl,
    this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final cardHeight = screenHeight * 0.15;
    final imageSize = screenHeight * 0.069;
    final basePadding = screenHeight * 0.018;

    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(basePadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image and Edit Button Column
            Column(
              children: [
                _buildProfileImage(imageSize),
                SizedBox(height: screenHeight * 0.008),
                _buildEditButton(screenHeight),
              ],
            ),
            SizedBox(width: basePadding * 1.2),
            // Name and Email
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.008),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: screenHeight * 0.021,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2D3748),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: screenHeight * 0.016,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF718096),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child:
          profileImageUrl != null
              ? ClipRRect(
                borderRadius: BorderRadius.circular(size / 2),
                child: Image.network(
                  profileImageUrl!,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildDefaultAvatar(size);
                  },
                ),
              )
              : _buildDefaultAvatar(size),
    );
  }

  Widget _buildDefaultAvatar(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
      ),
      child: Icon(Icons.person, size: size * 0.5, color: Colors.grey[600]),
    );
  }

  Widget _buildEditButton(double screenHeight) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFED8936),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            if (onEditPressed != null) {
              onEditPressed!();
            } else {
              _navigateToEditProfile();
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenHeight * 0.016,
              vertical: screenHeight * 0.007,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.edit,
                  size: screenHeight * 0.014,
                  color: Colors.white,
                ),
                SizedBox(width: screenHeight * 0.005),
                Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: screenHeight * 0.013,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToEditProfile() {
    Get.to(
      () => EditProfilel(),
      arguments: {
        'name': name,
        'email': email,
        'profileImageUrl': profileImageUrl,
      },
    );
  }
}
