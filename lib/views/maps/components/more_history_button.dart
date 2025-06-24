import 'package:flutter/material.dart';

class MoreHistoryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  const MoreHistoryButton({
    Key? key,
    required this.onPressed,
    this.text = 'More from recent history',
    this.textColor = const Color(0xFF5C837E),
    this.fontSize = 12,
    this.fontWeight = FontWeight.w500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
