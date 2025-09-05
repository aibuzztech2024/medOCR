import 'package:flutter/material.dart';

class CurrentLocationItem extends StatelessWidget {
  final VoidCallback onTap;

  const CurrentLocationItem({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: const Icon(Icons.my_location, color: Colors.black87, size: 20),
      title: const Text(
        'Your Current Location',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }
}
