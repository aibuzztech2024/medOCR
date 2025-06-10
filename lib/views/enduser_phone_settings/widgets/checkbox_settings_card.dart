import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Model class for checkbox menu items
class CheckboxMenuItemModel {
  final IconData icon;
  final String title;
  final RxBool isChecked;
  final VoidCallback? onChanged;
  final Color? iconColor;

  CheckboxMenuItemModel({
    required this.icon,
    required this.title,
    required bool isChecked,
    this.onChanged,
    this.iconColor,
  }) : isChecked = isChecked.obs;
}

/// Reusable Checkbox Settings Menu Widget
/// A customizable widget that displays a list of checkbox menu items in a card-like container
/// with consistent styling and interaction handling
class CheckboxSettingsWidget extends StatelessWidget {
  // List of checkbox menu items to display
  final List<CheckboxMenuItemModel> menuItems;

  // Customization properties for the widget appearance
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final Color? dividerColor;
  final double? iconSize;
  final TextStyle? textStyle;
  final Color? checkboxActiveColor;
  final Color? checkboxCheckColor;

  /// Constructor for CheckboxSettingsWidget
  /// [menuItems] is required, all other parameters are optional for customization
  const CheckboxSettingsWidget({
    Key? key,
    required this.menuItems,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.dividerColor,
    this.iconSize,
    this.textStyle,
    this.checkboxActiveColor,
    this.checkboxCheckColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Apply custom styling to the container
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Column(children: _buildMenuItems()),
      ),
    );
  }

  /// Build list of menu items with dividers
  List<Widget> _buildMenuItems() {
    List<Widget> widgets = [];

    for (int index = 0; index < menuItems.length; index++) {
      widgets.add(_buildCheckboxMenuItem(menuItems[index]));

      // Add divider between items (except for the last item)
      if (index < menuItems.length - 1) {
        widgets.add(const SizedBox(height: 1));
      }
    }

    return widgets;
  }

  /// Build individual checkbox menu item widget
  /// Creates a tappable row with icon, title, and checkbox
  /// [item] - The checkbox menu item model containing the data to display
  Widget _buildCheckboxMenuItem(CheckboxMenuItemModel item) {
    return Obx(
      () => Material(
        color: Colors.transparent,
        child: InkWell(
          // Handle tap interaction - toggle checkbox
          onTap: () => _toggleCheckbox(item),
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
            child: Row(
              children: [
                // Leading icon for the menu item
                Icon(
                  item.icon,
                  size: iconSize ?? 20.0,
                  color: item.iconColor ?? iconColor ?? Colors.grey[600],
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

                // Trailing checkbox
                GestureDetector(
                  onTap: () => _toggleCheckbox(item),
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    child: _buildCustomCheckbox(item.isChecked.value),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Toggle checkbox state and trigger callback
  void _toggleCheckbox(CheckboxMenuItemModel item) {
    item.isChecked.toggle();
    item.onChanged?.call();
  }

  /// Build custom checkbox widget to match design
  Widget _buildCustomCheckbox(bool isChecked) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        color:
            isChecked
                ? (checkboxActiveColor ?? const Color(0xFFFF8C00))
                : Colors.transparent,
        border: Border.all(
          color:
              isChecked
                  ? (checkboxActiveColor ?? const Color(0xFFFF8C00))
                  : Colors.grey.shade400,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child:
          isChecked
              ? Icon(
                Icons.check,
                color: checkboxCheckColor ?? Colors.white,
                size: 14.0,
              )
              : null,
    );
  }
}
