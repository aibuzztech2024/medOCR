import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/core/widgets/height_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

/// A reusable header widget that displays a title and an optional subtitle,
/// styled using the custom [AppText] utility.
///
/// This widget ensures:
/// - Centered alignment for both title and subtitle
/// - Responsive text sizing using [FittedBox] for the title
/// - Themed colors using [context.theme]
/// - A vertical space of 20 pixels below the text using [HeightBox]
class HeaderText extends StatelessWidget {
  /// The main title text to be displayed (required).
  final String title;

  /// The optional subtitle text displayed below the title.
  final String? subtitle;

  /// Creates a [HeaderText] widget with a [title] and optional [subtitle].
  const HeaderText({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: ListTile(
          tileColor: Colors.transparent,
          // Title text wrapped in FittedBox to handle overflow and scaling
          title: Center(
            child: AppText.heading(
              title,
              fontSize: 30,
              textAlign: TextAlign.center,
              color: context.theme.primaryColor,
            ),
          ),
          // Subtitle text shown only if provided
          subtitle: Center(
            child:
                subtitle != null
                    ? AppText.caption(
                      subtitle!,
                      fontSize: 14,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                      color: context.theme.hintColor,
                    )
                    : null,
          ),
        ),
      ),
    );
  }
}
