import 'package:flutter/material.dart';

/// Model class representing a menu item in the settings screen
/// Contains all the necessary data for displaying menu items with support for both IconData and SVG assets
class MenuItemModel {
  // Icon to be displayed for the menu item (IconData)
  final IconData? icon;

  // SVG asset path for the menu item icon
  final String? svgAsset;

  // Title text of the menu item
  final String title;

  // Optional callback function when item is tapped
  final VoidCallback? onTap;

  // Optional widget to navigate to when item is tapped
  final Widget? navigateTo;

  // Optional custom color for the icon (defaults to black if not provided)
  final Color? iconColor;

  // Optional flag to control arrow visibility
  final bool showArrow;

  /// Constructor for MenuItemModel
  /// Either [icon] OR [svgAsset] must be provided, but not both
  /// [title] is required
  /// [onTap], [navigateTo], [iconColor], and [showArrow] are optional
  MenuItemModel({
    this.icon,
    this.svgAsset,
    required this.title,
    this.onTap,
    this.navigateTo,
    this.iconColor,
    this.showArrow = true,
  }) : assert(
         (icon != null) ^ (svgAsset != null),
         'Either icon or svgAsset must be provided, but not both',
       );

  /// Factory constructor for creating menu item with IconData
  factory MenuItemModel.withIcon({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? navigateTo,
    Color? iconColor,
    bool showArrow = true,
  }) {
    return MenuItemModel(
      icon: icon,
      title: title,
      onTap: onTap,
      navigateTo: navigateTo,
      iconColor: iconColor,
      showArrow: showArrow,
    );
  }

  /// Factory constructor for creating menu item with SVG asset
  factory MenuItemModel.withSvg({
    required String svgAsset,
    required String title,
    VoidCallback? onTap,
    Widget? navigateTo,
    Color? iconColor,
    bool showArrow = true,
  }) {
    return MenuItemModel(
      svgAsset: svgAsset,
      title: title,
      onTap: onTap,
      navigateTo: navigateTo,
      iconColor: iconColor,
      showArrow: showArrow,
    );
  }

  /// Helper method to check if this menu item uses SVG
  bool get isSvg => svgAsset != null;

  /// Helper method to check if this menu item uses IconData
  bool get isIcon => icon != null;
}

/// Model class for user profile information
/// Contains user-related data displayed in the profile card
class UserProfileModel {
  // User's display name
  final String name;

  // User's email address
  final String email;

  // Asset path of the user's profile image
  final String? profileImageAsset;

  /// Constructor for UserProfileModel
  /// All parameters are required for complete user profile data
  UserProfileModel({
    required this.name,
    required this.email,
    this.profileImageAsset,
  });
}

/// Model class for settings section
/// Groups related menu items under a common section title
class SettingsSection {
  // Title of the settings section (e.g., "Account Settings")
  final String title;

  // List of menu items belonging to this section
  final List<MenuItemModel> menuItems;

  /// Constructor for SettingsSection
  /// Both [title] and [menuItems] are required
  SettingsSection({required this.title, required this.menuItems});
}
