import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  const LabeledTextField({
    Key? key,
    required this.label,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.labelStyle,
    this.textStyle,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 6.0,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive padding and sizing
    final horizontalPadding = screenWidth * 0.04; // 4% of screen width
    final verticalSpacing = screenWidth * 0.02; // 2% of screen width
    final fontSize = screenWidth * 0.04; // 4% of screen width, with constraints

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding.clamp(12.0, 24.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text
          Padding(
            padding: EdgeInsets.only(bottom: verticalSpacing.clamp(6.0, 12.0)),
            child: Text(
              label,
              style:
                  labelStyle ??
                  TextStyle(
                    fontSize: fontSize.clamp(14.0, 18.0),
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
            ),
          ),

          // Text field with container
          Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
              border: Border.all(
                color: borderColor ?? Colors.grey.shade300,
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              validator: validator,
              onChanged: onChanged,
              onSaved: onSaved,
              enabled: enabled,
              maxLines: maxLines,
              minLines: minLines,
              style:
                  textStyle ??
                  TextStyle(
                    fontSize: fontSize.clamp(14.0, 16.0),
                    color: Colors.black87,
                  ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: fontSize.clamp(14.0, 16.0),
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding:
                    contentPadding ??
                    EdgeInsets.symmetric(
                      horizontal: horizontalPadding.clamp(12.0, 16.0),
                      vertical: verticalSpacing.clamp(12.0, 16.0),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
