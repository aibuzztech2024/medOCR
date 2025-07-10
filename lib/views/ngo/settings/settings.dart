import 'package:avatar/views/ngo/settings/widgets.dart';
import 'package:flutter/material.dart';

class NgoSettings extends StatelessWidget {
  const NgoSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MainSettingsTile(title: 'Account Information', onTap: () {}),
              MainSettingsTile(title: 'Organization Details', onTap: () {}),
              MainSettingsTile(
                title: 'Registration and Tax Details',
                onTap: () {},
              ),

              MainSettingsTile(title: 'Contact Person', onTap: () {}),
              const PrivacyActivityContainer(),
              const AccountSettingsContainer(),
              const TermsAndConditionsContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
