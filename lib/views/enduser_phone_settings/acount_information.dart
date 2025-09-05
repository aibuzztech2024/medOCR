import 'package:avatar/views/enduser_phone_settings/widgets/country_code_picker.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/labeled_text_field.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/profile_image.dart';
import 'package:flutter/material.dart';

class AccountInformationPage extends StatelessWidget {
  const AccountInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(child: ProfileImageWidget()),
          const SizedBox(height: 20),
          LabeledTextField(
            label: 'Name',
            controller: TextEditingController(),
            hintText: 'Guarav Yadav',
          ),
          const SizedBox(height: 20),
          LabeledTextField(
            label: 'Email Address',
            controller: TextEditingController(),
            hintText: 'guarav@gmail.com',
          ),
          const SizedBox(height: 20),

          StyledCountryPicker(
            onSelect: (value) {
              print(value);
            },
          ),
        ],
      ),
    );
  }
}
