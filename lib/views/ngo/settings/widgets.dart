import 'package:flutter/material.dart';

// Constants
const Color kBackgroundColor = Color(0xFFF8F9FA);
const Color kPrimaryTextColor = Color(0xFF484848);
const Color kLinkTextColor = Color(0xFF6B79F5);

/// 🔹 1. Main Tile (Used in top-level items)
class MainSettingsTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MainSettingsTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: Text(
              title,
              style: const TextStyle(
                color: kPrimaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: kPrimaryTextColor,
            ),
            dense: true,
            visualDensity: VisualDensity.compact,
          ),
        ),
      ),
    );
  }
}

/// 🔹 2. Subsection Tile (Used inside grouped containers)
class SubsectionTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SubsectionTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              color: kLinkTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}

/// 🔹 3. Reusable Section Container
class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  const SettingsSection({super.key, required this.title, required this.tiles});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryTextColor,
                ),
              ),
            ),
            ...tiles,
          ],
        ),
      ),
    );
  }
}

/// 🔹 4. Privacy and Activity Section
class PrivacyActivityContainer extends StatelessWidget {
  const PrivacyActivityContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Privacy And Activity',
      tiles: [
        SubsectionTile(title: 'Change Password', onTap: () {}),
        SubsectionTile(title: 'Clear Search History', onTap: () {}),
        SubsectionTile(title: 'Clear Save Data', onTap: () {}),
      ],
    );
  }
}

/// 🔹 5. Account Settings Section
class AccountSettingsContainer extends StatelessWidget {
  const AccountSettingsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Account Settings',
      tiles: [SubsectionTile(title: 'Account Delete', onTap: () {})],
    );
  }
}

/// 🔹 6. Terms and Conditions Section
class TermsAndConditionsContainer extends StatelessWidget {
  const TermsAndConditionsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Terms and Conditions',
      tiles: [
        SubsectionTile(title: 'Terms of Usage', onTap: () {}),
        SubsectionTile(title: 'Privacy and Policy', onTap: () {}),
        SubsectionTile(title: 'Disclaimer', onTap: () {}),
      ],
    );
  }
}
