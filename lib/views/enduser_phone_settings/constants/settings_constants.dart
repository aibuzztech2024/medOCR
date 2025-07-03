import 'package:flutter/material.dart';
import '../menu_item_model.dart';
import '../widgets/custom_popup.dart';

/// Constants for settings screen
class SettingsConstants {
  // Default user profile data
  static final UserProfileModel defaultUserProfile = UserProfileModel(
    name: 'Guarav Yadav',
    email: 'guarav12@gmail.com',
    profileImageAsset: 'assets/images/character_1.png',
  );

  // Account deletion reasons
  static const List<String> accountDeletionReasons = [
    'I found a better alternative',
    'The app is hard to use',
    'Not getting enough value',
    'Just taking a break',
    'Other (please specify)',
  ];

  // Terms and conditions content
  static final List<DialogSection> termsOfUsageSections = [
    const DialogSection(
      title: '1. Introduction',
      content:
          'Welcome to Avatar ("Company", "we", "our", "us")! '
          'These Terms of Service ("Terms", "Terms of Service") govern your '
          'use of our mobile application and services (together or individually "Service") '
          'operated by Avatar. Our Privacy Policy also governs your use of our Service '
          'and explains how we collect, safeguard and disclose information that results from your use of our services. '
          'Your agreement with these Terms includes these Terms and our Privacy Policy ("Agreements"). '
          'By visiting our application you acknowledge that you have read and understood Agreements, '
          'and agree to be bound by them.',
    ),
    const DialogSection(
      title: '2. Communications',
      content:
          'By using our Service, you agree to subscribe to newsletters, '
          'marketing or promotional materials and other information we may send. '
          'However, you may opt out of receiving any, or all, of these communications from us '
          'by following the unsubscribe link or by contacting us through the app settings. '
          'If you do not agree with (or cannot comply with) these Terms, you may not use the Service. '
          'However, please let us know by emailing our support team, so we can try to find a solution. ',
    ),
  ];

  // Privacy policy content (same as terms for now)
  static final List<DialogSection> privacyPolicySections = termsOfUsageSections;

  // Disclaimer content (same as terms for now)
  static final List<DialogSection> disclaimerSections = termsOfUsageSections;

  // Colors
  static const Color primaryRed = Color(0xFFB0020A);
  static const Color primaryOrange = Color(0xFFFF9800);
  static const Color primaryGreen = Color(0xFF3AAFA9);
  static const Color secondaryGreen = Color(0xFFE4FFFE);

  static const Color sectionBackground = Color(0xFFFFF8E9);
}
