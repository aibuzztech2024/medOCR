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

    // Dynamic height calculation: 48/874 of screen height with minimum height
    double dynamicHeight = height ?? Get.height * (48 / 874);
    dynamicHeight = dynamicHeight.clamp(
      44.0,
      56.0,
    ); // Ensure reasonable height range

    // Calculate font size and icon size for better proportions
    double fontSize = (dynamicHeight * 0.3).clamp(12.0, 16.0);
    double iconSize = (dynamicHeight * 0.4).clamp(18.0, 24.0);

    return Container(
      width: dynamicWidth,
      height: dynamicHeight,
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
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Ensure center alignment
              children: [
                // Search Icon with proper centering
                Container(
                  width:
                      dynamicHeight, // Square container for perfect centering
                  height: dynamicHeight,
                  child: Center(
                    child: Icon(
                      prefixIcon,
                      color: prefixIconColor ?? const Color(0xFF757575),
                      size: iconSize,
                    ),
                  ),
                ),

                // Text Field - expandable to fill remaining space
                Expanded(
                  child: Container(
                    height: dynamicHeight,
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      controller: controller,
                      onChanged: onChanged,
                      onSubmitted: onSubmitted,
                      readOnly: readOnly,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: const Color(0xFF212121),
                        height:
                            1.0, // Set line height to 1.0 for better alignment
                      ),
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle:
                            hintTextStyle ??
                            TextStyle(
                              color: hintTextColor ?? const Color(0xFF9E9E9E),
                              fontSize: fontSize,
                              fontWeight: FontWeight.w400,
                              height: 1.0, // Match text height
                            ),
                        // Remove all borders for clean appearance
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        // Use isCollapsed to remove default padding
                        isCollapsed: true,
                        contentPadding: EdgeInsets.zero,
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

                      return Container(
                        width: dynamicHeight * 0.8, // Proportional width
                        height: dynamicHeight,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              // Clear text and notify listeners
                              controller!.clear();
                              onChanged?.call('');
                            },
                            child: Icon(
                              Icons.clear,
                              color: const Color(0xFF757575),
                              size:
                                  iconSize * 0.9, // Slightly smaller clear icon
                            ),
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
