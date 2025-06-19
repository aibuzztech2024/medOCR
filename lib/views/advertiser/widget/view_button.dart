import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewButton extends StatelessWidget {
  final String text;
  final IconData? dropdownIcon;
  final VoidCallback? onTap;
  final List<ViewOption>? options;
  final ViewOption? selectedOption;
  final Function(ViewOption)? onOptionSelected;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final TextStyle? textStyle;
  final bool showBorder;
  final Color? borderColor;

  const ViewButton({
    Key? key,
    this.text = 'View',
    this.dropdownIcon = Icons.keyboard_arrow_down,
    this.onTap,
    this.options,
    this.selectedOption,
    this.onOptionSelected,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.padding,
    this.margin,
    this.borderRadius = 4.0,
    this.textStyle,
    this.showBorder = true,
    this.borderColor,
  }) : super(key: key);

  /// Calculate dynamic width based on screen ratio (97:402)
  double _getDynamicWidth(BuildContext context) {
    final screenWidth = Get.width;
    return screenWidth * (97 / 402);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _getDynamicWidth(context), // Dynamic width based on screen ratio
      margin: margin,
      child: PopupMenuButton<ViewOption>(
        onSelected: onOptionSelected,
        // Build popup menu items
        itemBuilder: (context) => _buildMenuItems(),
        child: _buildButtonContainer(),
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  /// Build popup menu items from options list
  List<PopupMenuItem<ViewOption>> _buildMenuItems() {
    return options?.map((option) {
          return PopupMenuItem<ViewOption>(
            value: option,
            child: Row(
              children: [
                // Show icon if available
                if (option.icon != null) ...[
                  Icon(option.icon, size: 18),
                  const SizedBox(width: 8),
                ],
                Text(option.label),
              ],
            ),
          );
        }).toList() ??
        [];
  }

  /// Build main button container with styling
  Container _buildButtonContainer() {
    return Container(
      padding:
          padding ??
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.shade100,
        // Conditional border styling
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Display selected option or default text
          Expanded(
            child: Text(
              selectedOption?.label ?? text,
              style:
                  textStyle ??
                  TextStyle(
                    color: textColor ?? Colors.black87,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
              overflow: TextOverflow.ellipsis, // Handle long text
            ),
          ),
          const SizedBox(width: 4.0),
          // Dropdown arrow icon
          Icon(dropdownIcon, color: iconColor ?? Colors.grey[600], size: 18.0),
        ],
      ),
    );
  }
}

/// Model class for view options
class ViewOption {
  final String label;
  final String value;
  final IconData? icon;

  const ViewOption({required this.label, required this.value, this.icon});
}
