import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/core/widgets/height_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A custom button widget that represents a selectable option,
/// such as a role, filter, or choice in a form or selection screen.
///
/// The button displays a [title] and a [caption], and visually
/// highlights itself if [isSelected] is true.
///
class SelectableButton extends StatelessWidget {
  /// Whether the button is currently selected.
  final bool isSelected;

  /// Callback triggered when the button is tapped.
  final VoidCallback onTap;

  /// Main text to display (usually a title).
  final String title;

  /// Supporting text displayed below the title.
  final String caption;

  /// Creates a [SelectableButton] widget.
  const SelectableButton({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.title,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Set the width of the button to match the screen width
      width: context.width,
      child: ElevatedButton(
        onPressed:
            onTap, // Trigger the provided callback when the button is tapped
        style: ElevatedButton.styleFrom(
          // Set background color based on selection state
          backgroundColor:
              isSelected
                  ? context.theme.primaryColor
                  : context.theme.scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8,
            ), // Rounded corners for the button
            side:
                isSelected
                    ? BorderSide(
                      color: Colors.transparent,
                    ) // No border when selected
                    : BorderSide(
                      color: context.theme.primaryColor,
                      width: 1.5, // Colored border when not selected
                    ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ), // Internal padding
        ),
        child: SizedBox(
          width: double.infinity, // Take full available width inside the button
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align text to the start
            children: [
              // Display the main title text
              AppText.heading(
                title,
                fontSize: 16,
                color: isSelected ? Colors.white : context.theme.primaryColor,
              ),
              HeightBox(2),
              // Display the subtitle or description text
              AppText.caption(
                caption,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                overflow:
                    TextOverflow.ellipsis, // Handle overflow with ellipsis
                color: isSelected ? Colors.white70 : context.theme.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
