import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';

// Sets default country to india
Rx<Country> country = CountryParser.parse('IN').obs;

/// Country picker widget with LabeledTextField styling
/// This widget matches the UI design of LabeledTextField
class StyledCountryPicker extends StatelessWidget {
  final Function(Country value) onSelect;
  final String label;
  final TextStyle? labelStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;
  final double? height; // Added height parameter
  final EdgeInsetsGeometry?
  margin; // Added margin parameter for external spacing

  const StyledCountryPicker({
    Key? key,
    required this.onSelect,
    this.label = 'Country Code',
    this.labelStyle,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 6.0,
    this.contentPadding,
    this.enabled = true,
    this.height, // Optional height parameter
    this.margin, // Optional margin parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive design (matching LabeledTextField)
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive padding and sizing (matching LabeledTextField)
    final horizontalPadding = screenWidth * 0.04; // 4% of screen width
    final verticalSpacing = screenWidth * 0.02; // 2% of screen width
    final fontSize = screenWidth * 0.04; // 4% of screen width, with constraints

    // Calculate height to match TextFormField (increased by 2px)
    final containerHeight =
        height ??
        (verticalSpacing.clamp(12.0, 16.0) * 2 +
            fontSize.clamp(14.0, 16.0) * 1.4 +
            4.0);

    // Default margin with left padding to match other form fields
    final defaultMargin = EdgeInsets.only(
      left: horizontalPadding.clamp(12.0, 16.0),
    );

    return Container(
      margin: margin ?? defaultMargin,
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label text (matching LabeledTextField)
            if (label.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(
                  bottom: verticalSpacing.clamp(6.0, 12.0),
                ),
                child: Text(
                  label,
                  style:
                      labelStyle ??
                      TextStyle(
                        fontSize: fontSize.clamp(14.0, 18.0),
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                ),
              ),

            // Country picker container
            Container(
              decoration: BoxDecoration(
                color: backgroundColor ?? Colors.white,
                borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
                border: Border.all(
                  color: borderColor ?? Colors.grey.shade300,
                  width: 1.0,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
                  onTap:
                      enabled
                          ? () {
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
                          }
                          : null,
                  child: Container(
                    height: containerHeight,
                    padding:
                        contentPadding ??
                        EdgeInsets.symmetric(
                          horizontal: horizontalPadding.clamp(12.0, 16.0),
                          vertical: verticalSpacing.clamp(12.0, 16.0),
                        ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Selected Country flag
                        Obx(() {
                          return Text(
                            country.value.flagEmoji,
                            style: TextStyle(
                              fontSize: fontSize.clamp(18.0, 20.0),
                              height: 1.0,
                            ),
                          );
                        }),
                        SizedBox(width: 6),
                        // Country code
                        Obx(() {
                          return Text(
                            '+${country.value.phoneCode}',
                            style: TextStyle(
                              fontSize: fontSize.clamp(14.0, 16.0),
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              height: 1.0,
                            ),
                          );
                        }),
                        SizedBox(width: 4),
                        // Dropdown icon
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: enabled ? Colors.black54 : Colors.grey,
                          size: fontSize.clamp(
                            16.0,
                            20.0,
                          ), // Responsive icon size
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
