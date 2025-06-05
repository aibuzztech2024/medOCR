import 'package:avatar/views/enduser_phone_settings/menu_item_model.dart';
import 'package:flutter/material.dart';

/// Reusable Settings Menu Widget
/// A customizable widget that displays a list of menu items in a card-like container
/// with consistent styling and interaction handling
class SettingsMenuWidget extends StatelessWidget {
  // List of menu items to display
  final List<MenuItemModel> menuItems;

  // Customization properties for the widget appearance
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final Color? arrowColor;
  final Color? dividerColor;
  final double? iconSize;
  final TextStyle? textStyle;

  /// Constructor for SettingsMenuWidget
  /// [menuItems] is required, all other parameters are optional for customization
  const SettingsMenuWidget({
    Key? key,
    required this.menuItems,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.arrowColor,
    this.dividerColor,
    this.iconSize,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Apply custom styling to the container
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
        // Add shadow for depth and modern appearance
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: Column(
          children: List.generate(
            menuItems.length,
            (index) => _buildMenuItem(menuItems[index]),
          ),
        ),
      ),
    );
  }

  /// Build individual menu item widget
  /// Creates a tappable row with icon, title, and arrow indicator
  /// [item] - The menu item model containing the data to display
  Widget _buildMenuItem(MenuItemModel item) {
    return InkWell(
      // Handle tap interaction
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Row(
          children: [
            // Leading icon for the menu item
            Icon(
              item.icon,
              size: iconSize ?? 15.0,
              color: item.iconColor ?? iconColor ?? Colors.black,
            ),
            const SizedBox(width: 16.0),

            // Expandable title text
            Expanded(
              child: Text(
                item.title,
                style:
                    textStyle ??
                    TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: textColor ?? Colors.black87,
                    ),
              ),
            ),

            // Trailing arrow indicator
            Icon(
              Icons.chevron_right,
              size: 20.0,
              color: arrowColor ?? Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}
