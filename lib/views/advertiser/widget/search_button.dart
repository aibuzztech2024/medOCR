import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool readOnly;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double borderRadius;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final Color? hintTextColor;
  final TextStyle? hintTextStyle;
  final double? width;
  final double? height;
  final double elevation;

  const CustomSearchBar({
    Key? key,
    this.hintText = 'Search by medicine name or categories',
    this.onTap,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.readOnly = false,
    this.padding,
    this.backgroundColor,
    this.borderRadius = 6.0,
    this.prefixIcon = Icons.search,
    this.prefixIconColor,
    this.hintTextColor,
    this.hintTextStyle,
    this.width,
    this.height,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dynamic width calculation: 366/402 of screen width
    double dynamicWidth = width ?? Get.width * (366 / 402);

    // Dynamic height calculation: 48/874 of screen height
    double dynamicHeight = height ?? Get.height * (48 / 874);

    return Container(
      width: dynamicWidth,
      height: dynamicHeight,
      // Use provided padding or default to zero for external alignment control
      padding: padding ?? EdgeInsets.zero,
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor ?? const Color(0xFFF5F5F5),
        child: GestureDetector(
          onTap: readOnly ? onTap : null,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Row(
              children: [
                // Search Icon with consistent padding
                Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.04,
                    right: Get.width * 0.03,
                  ),
                  child: Icon(
                    prefixIcon,
                    color: prefixIconColor ?? const Color(0xFF757575),
                    size: Get.textScaleFactor * 20.0,
                  ),
                ),

                // Text Field - expandable to fill remaining space
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    onSubmitted: onSubmitted,
                    readOnly: readOnly,
                    style: TextStyle(
                      fontSize: Get.textScaleFactor * 14.0,
                      color: const Color(0xFF212121),
                    ),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle:
                          hintTextStyle ??
                          TextStyle(
                            color: hintTextColor ?? const Color(0xFF9E9E9E),
                            fontSize: Get.textScaleFactor * 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                      // Remove all borders for clean appearance
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      // Vertical padding adjusted for dynamic height
                      contentPadding: EdgeInsets.symmetric(
                        vertical: dynamicHeight * 0.3,
                      ),
                    ),
                  ),
                ),

                // Clear button - shows only when text is present
                if (controller != null)
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: controller!,
                    builder: (context, value, child) {
                      // Hide clear button when text is empty
                      if (value.text.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return GestureDetector(
                        onTap: () {
                          // Clear text and notify listeners
                          controller!.clear();
                          onChanged?.call('');
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: Get.width * 0.04),
                          child: Icon(
                            Icons.clear,
                            color: const Color(0xFF757575),
                            size: Get.textScaleFactor * 18.0,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
