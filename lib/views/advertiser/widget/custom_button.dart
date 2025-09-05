import 'package:flutter/material.dart';

// Reusable Custom Button Widget
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isOutlined;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.textColor = Colors.white,
    this.backgroundColor = const Color(0xFFFF6B6B),
    this.borderColor,
    this.borderWidth = 1.5,
    this.borderRadius = 10,
    this.padding,
    this.isOutlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child:
          isOutlined
              ? OutlinedButton(
                onPressed: onPressed,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: borderColor ?? backgroundColor,
                    width: borderWidth,
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  padding: padding,
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: borderColor ?? backgroundColor,
                    fontWeight: fontWeight,
                  ),
                ),
              )
              : ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  foregroundColor: textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  padding: padding,
                  elevation: 0,
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: textColor,
                    fontWeight: fontWeight,
                  ),
                ),
              ),
    );
  }
}
