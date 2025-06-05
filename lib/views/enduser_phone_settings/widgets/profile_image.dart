import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback? onEditPressed;
  final double size;
  final Color borderColor;
  final double borderWidth;
  final Color editButtonColor;
  final IconData editIcon;

  const ProfileImageWidget({
    Key? key,
    this.imageUrl =
        'https://img.freepik.com/free-photo/portrait-smiling-cute-little-girl_23-2147851843.jpg',
    this.onEditPressed,
    this.size = 134.0,
    this.borderColor = Colors.white,
    this.borderWidth = 3.0,
    this.editButtonColor = const Color(0xFFFF8C00),
    this.editIcon = Icons.edit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Make the widget responsive based on screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final responsiveSize = size * (screenWidth < 600 ? 0.8 : 1.0);
    final editButtonSize =
        responsiveSize * 0.179; // Maintains proportion (24/134)

    return Container(
      width: responsiveSize,
      height: responsiveSize,
      child: Stack(
        children: [
          // Main profile image container with shadow and border
          Container(
            width: responsiveSize,
            height: responsiveSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              margin: EdgeInsets.all(borderWidth),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image:
                    imageUrl != null
                        ? DecorationImage(
                          image: NetworkImage(imageUrl!),
                          fit: BoxFit.cover,
                        )
                        : null,
                color: imageUrl == null ? Colors.grey[300] : null,
              ),
              child:
                  imageUrl == null
                      ? Icon(
                        Icons.person,
                        size: responsiveSize * 0.4,
                        color: Colors.grey[600],
                      )
                      : null,
            ),
          ),
          // Edit button positioned at bottom right
          Positioned(
            bottom: 0,
            right: 12,
            child: GestureDetector(
              onTap: onEditPressed,
              child: Container(
                width: editButtonSize,
                height: editButtonSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: editButtonColor,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  editIcon,
                  color: Colors.white,
                  size: editButtonSize * 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
