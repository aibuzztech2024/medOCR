import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

/// Button style types: [filled] for solid background, [outlined] for bordered style, and [text] for text button style.
enum ButtonType { filled, outlined, text }

/// A customizable app-wide button supporting filled, outlined, and text styles.
///
/// You must provide **either** [text] or a custom [child] widget — not both.
class AppButton extends StatelessWidget {
  /// Defines the visual style of the button: filled, outlined, or text.
  final ButtonType type;

  /// Callback when the button is pressed. If null, the button will be disabled.
  final VoidCallback? onPressed;

  /// Optional text to display on the button. Required if [child] is not provided.
  final String? text;

  /// Optional custom widget to display inside the button.
  /// Required if [text] is not provided.
  final Widget? child;

  /// Background color for filled button or border/text color for outlined and text buttons.
  final Color? color;

  /// Text color for the filled button or for text/outlined button text.
  final Color? textColor;

  /// The border radius of the button. Defaults to `12.0`.
  final double? borderRadius;

  /// Padding inside the button. Defaults vary by button type.
  final EdgeInsetsGeometry? padding;

  /// Width of button
  final double? width;

  /// Height of button
  final double? height;

  /// Creates a styled button.
  ///
  /// Either [text] or [child] must be provided (not both).
  const AppButton({
    super.key,
    required this.type,
    this.text,
    this.child,
    this.onPressed,
    this.color,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
  }) : assert(
         (text != null && child == null) || (text == null && child != null),
         'You must provide either `text` or `child`, not both or neither.',
       );

  @override
  Widget build(BuildContext context) {
    final borderRadiusValue = borderRadius ?? 12.0;

    // Default paddings based on button type
    final defaultPadding =
        type == ButtonType.text
            ? const EdgeInsets.symmetric(horizontal: 2)
            : const EdgeInsets.symmetric(vertical: 13);

    final buttonPadding = padding ?? defaultPadding;

    // Determine the button content
    Widget content;
    if (text != null) {
      content =
          type == ButtonType.outlined
              ? AppText.heading(
                text!,
                color: color ?? context.theme.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )
              : AppText(
                text!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color:
                      textColor ??
                      (type == ButtonType.text
                          ? (color ?? context.theme.primaryColor)
                          : Colors.white),
                ),
              );
    } else {
      content = child!;
    }

    // Return styled button based on type
    switch (type) {
      case ButtonType.filled:
        return SizedBox(
          height: height,
          width: width,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color ?? Theme.of(context).primaryColor,
              foregroundColor: textColor ?? Colors.white,
              padding: buttonPadding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadiusValue),
              ),
            ),
            child: content,
          ),
        );

      case ButtonType.outlined:
        return SizedBox(
          height: height,
          width: width,
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: color ?? Theme.of(context).primaryColor,
              padding: buttonPadding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadiusValue),
              ),
              side: BorderSide(
                color: color ?? Theme.of(context).primaryColor,
                width: 1.5,
              ),
            ),
            child: content,
          ),
        );

      case ButtonType.text:
        return SizedBox(
          height: height,
          width: width,
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding:
                  padding ?? EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: content,
          ),
        );
    }
  }
}
