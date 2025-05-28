import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String status;
  final Color backgroundColor;
  final Color textColor;

  const StatusChip({
    super.key,
    required this.status,
    this.backgroundColor = const Color(0xFFE6F8EC),
    this.textColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        constraints: const BoxConstraints(minWidth: 0),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            status,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
