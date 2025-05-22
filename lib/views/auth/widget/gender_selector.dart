import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Shows a bottom sheet allowing the user to select a gender.
///
/// Returns 'M' if Male is selected, 'F' if Female is selected.
Future<String> showGenderSelector(BuildContext context) async {
  var gender = await showModalBottomSheet(
    backgroundColor: context.theme.scaffoldBackgroundColor,
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Option: Male
          ListTile(
            title: AppText.heading('Male', color: context.theme.primaryColor),
            leading: Icon(
              Icons.male,
              color: context.theme.primaryColor,
              size: 26,
            ),
            onTap: () {
              Navigator.pop(context, 'M');
            },
          ),
          Divider(),

          // Option: Female
          ListTile(
            title: AppText.heading('Female', color: context.theme.primaryColor),
            leading: Icon(
              Icons.female,
              color: context.theme.primaryColor,
              size: 26,
            ),
            onTap: () {
              Navigator.pop(context, 'F');
            },
          ),
        ],
      );
    },
  );

  return gender;
}
