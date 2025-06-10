import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
// Import your AppButton widget
// import 'package:avatar/core/widgets/app_button.dart';

class CustomNavBar extends StatelessWidget {
  final String cancelText;
  final String submitText;
  final VoidCallback? onCancel;
  final VoidCallback? onSubmit;
  final Color? cancelTextColor;
  final Color? submitTextColor;
  final Color? submitBackgroundColor;
  final Color? backgroundColor;

  const CustomNavBar({
    Key? key,
    this.cancelText = 'Cancel',
    this.submitText = 'Submit',
    this.onCancel,
    this.onSubmit,
    this.cancelTextColor,
    this.submitTextColor,
    this.submitBackgroundColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.15),
            offset: const Offset(0, -2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Cancel Button using AppButton
            AppButton(
              type: ButtonType.filled,
              child: AppText(
                cancelText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: onCancel,
              color: Colors.yellow.shade100,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              borderRadius: 8,
              height: 41,
            ),

            // Submit Button using AppButton
            AppButton(
              type: ButtonType.filled,
              child: AppText(
                submitText,
                style: TextStyle(
                  color: submitTextColor ?? Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: onSubmit,
              color: submitBackgroundColor ?? const Color(0xFFFF8C42),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              borderRadius: 8,
              height: 41,
            ),
          ],
        ),
      ),
    );
  }
}
