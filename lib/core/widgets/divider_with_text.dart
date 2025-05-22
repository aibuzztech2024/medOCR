import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

/// A custom widget that displays a horizontal divider line with text in the center.
///
/// This widget is typically used to visually separate sections with a label
/// in between, such as "OR", "Continue with Email", etc.
class DividerWithText extends StatelessWidget {
  /// The text to be displayed in the center of the divider.
  final String middleText;

  /// The [middleText] parameter must not be null.
  const DividerWithText(this.middleText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left divider line
        Expanded(child: Divider(color: context.theme.primaryColor, height: 1)),

        // Middle text with horizontal padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: AppText.body(middleText, color: context.theme.primaryColor),
        ),

        // Right divider line
        Expanded(child: Divider(color: context.theme.primaryColor, height: 1)),
      ],
    );
  }
}
