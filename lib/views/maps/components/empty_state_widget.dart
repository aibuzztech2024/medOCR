import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final double fontSize;
  final Color textColor;

  const EmptyStateWidget({
    Key? key,
    this.message = 'No locations found',
    this.fontSize = 16,
    this.textColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
    );
  }
}
