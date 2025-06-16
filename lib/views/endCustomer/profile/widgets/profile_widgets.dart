import 'package:avatar/core/constants/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

/// TO-DO change asset image to network image
class ProfileHeader extends StatelessWidget {
  final String name;
  final String userType;
  final String imageUrl;

  const ProfileHeader({super.key, required this.name, required this.userType, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Row(
          children: [
            CircleAvatar(radius: 28, backgroundImage: AssetImage(imageUrl)),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  Text(userType, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

/// TO-DO change asset image to network image
class BadgeCard extends StatelessWidget {
  const BadgeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(ImagePaths.diamond_Badge, height: 50),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Diamond badge', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4),
                  Text(
                    '• All Gold-level benefits\n• Special mentions in community spaces\n• Invitations to participate in feedback sessions',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData? icon;
  final String? svgPath;
  final String title;
  final VoidCallback onPressed;
  final Color? color;

  const MenuItem({super.key, this.icon, this.svgPath, required this.title, required this.onPressed, this.color})
      : assert(icon != null || svgPath != null, 'Either icon or svgPath must be provided');

  @override
  Widget build(BuildContext context) {
    final isColored = color != null;

    Widget leadingIcon;
    if (icon != null) {
      leadingIcon = Icon(icon, color: isColored ? Colors.white : Colors.black, size: 24);
    } else {
      leadingIcon = SvgPicture.asset(svgPath!, width: 24, height: 24, color: isColored ? Colors.white : Colors.black);
    }

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(color: isColored ? color : Colors.transparent, borderRadius: BorderRadius.circular(25)),
        child: Row(
          children: [
            leadingIcon,
            const SizedBox(width: 6),
            Text(title, style: TextStyle(color: isColored ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

