import 'package:flutter/material.dart';

/// Model class representing a menu item in the settings screen
/// Contains all the necessary data for displaying menu items
class MenuItemModel {
  // Icon to be displayed for the menu item
  final IconData icon;

  // Title text of the menu item
  final String title;

  // Optional callback function when item is tapped
  final VoidCallback? onTap;

  // Optional widget to navigate to when item is tapped
  final Widget? navigateTo;

  // Optional custom color for the icon (defaults to black if not provided)
  final Color? iconColor;

  /// Constructor for MenuItemModel
  /// [icon] and [title] are required parameters
  /// [onTap], [navigateTo], and [iconColor] are optional
  MenuItemModel({
    required this.icon,
    required this.title,
    this.onTap,
    this.navigateTo,
    this.iconColor,
  });
}

/// Model class for user profile information
/// Contains user-related data displayed in the profile card
class UserProfileModel {
  // User's display name
  final String name;

  // User's email address
  final String email;

  // URL of the user's profile image
  final String profileImageUrl;

  /// Constructor for UserProfileModel
  /// All parameters are required for complete user profile data
  UserProfileModel({
    required this.name,
    required this.email,
    required this.profileImageUrl,
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
