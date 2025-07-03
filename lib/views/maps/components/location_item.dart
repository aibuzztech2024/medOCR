import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocationItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final IconData? leadingIcon;
  final String? leadingIconPath;

  const LocationItem({
    Key? key,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.leadingIcon,
    this.leadingIconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading:
          leadingIcon != null
              ? Icon(leadingIcon, color: Colors.black87, size: 20)
              : leadingIconPath != null
              ? SvgPicture.asset(leadingIconPath!)
              : SvgPicture.asset('assets/icons/maps/searched_icon.svg'),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      subtitle:
          subtitle != null
              ? Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              )
              : null,
      onTap: onTap,
    );
  }
}
