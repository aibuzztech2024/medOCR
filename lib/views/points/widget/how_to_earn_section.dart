import 'package:flutter/material.dart';

//this is the how to earn section used in points screen
class HowToEarnSection extends StatelessWidget {
  final String title;
  final String description;

  const HowToEarnSection({
    super.key,
    this.title = 'How To Earn Points',
    this.description =
        'Points expire in 6-12 months (your choice) if not used — keeps users active.)',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
