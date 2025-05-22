import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/core/widgets/width_box.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Sets default country to india
Rx<Country> country = CountryParser.parse('IN').obs;

/// Country picker widget
/// This widget is used to select a country
class AppCountryPicker extends StatelessWidget {
  final Function(Country value) onSelect;
  const AppCountryPicker({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      height: 50,
      child: AppButton(
        type: ButtonType.outlined,
        padding: EdgeInsets.symmetric(vertical: 2),
        onPressed: () {
          // Shows country picker
          showCountryPicker(
            context: context,
            // Invokes select country method and updates it
            onSelect: (val) {
              // Updates country code
              country.value = val;
              Get.log(country.value.displayName);
              // Invokes onSelect method
              onSelect(val);
            },
          );
        },
        // Adds padding to flag and dropdown icon
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          // Selected country flag and dropdown icon
          child: Row(
            children: [
              // Selected Country flag
              Obx(() {
                return AppText.heading(country.value.flagEmoji, fontSize: 30);
              }),
              WidthBox(2),
              // Dropdown icon
              Icon(
                Icons.keyboard_arrow_down,
                color: context.theme.primaryColor,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
