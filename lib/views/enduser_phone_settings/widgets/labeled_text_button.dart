import 'package:flutter/material.dart';

/// Custom widget for displaying labeled text in a styled container
/// Used to show text in a read-only format with optional trailing widgets
class LabeledTextDisplay extends StatelessWidget {
  final String? label; // Made optional
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final double? height; // Adjustable height
  final List<Widget>? trailingWidgets; // Widgets to display after text
  final MainAxisAlignment? trailingAlignment; // Alignment for trailing widgets
  final double? trailingSpacing; // Spacing between trailing widgets

  const LabeledTextDisplay({
    Key? key,
    this.label, // Made optional
    required this.value,
    this.labelStyle,
    this.valueStyle,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 6.0,
    this.contentPadding,
    this.height, // Optional height constraint
    this.trailingWidgets, // Optional trailing widgets
    this.trailingAlignment = MainAxisAlignment.end,
    this.trailingSpacing = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size screenSize = mediaQuery.size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final Orientation orientation = mediaQuery.orientation;

    // Dynamic sizing based on screen size and orientation
    final bool isTablet = screenWidth >= 768;
    final bool isDesktop = screenWidth >= 1024;
    final bool isLandscape = orientation == Orientation.landscape;

    // Responsive padding calculations
    double horizontalPaddingFactor;
    double verticalSpacingFactor;
    double fontSizeFactor;

    if (isDesktop) {
      horizontalPaddingFactor = 0.02; // 2% for desktop
      verticalSpacingFactor = 0.015; // 1.5% for desktop
      fontSizeFactor = 0.025; // 2.5% for desktop
    } else if (isTablet) {
      horizontalPaddingFactor = 0.03; // 3% for tablet
      verticalSpacingFactor = 0.018; // 1.8% for tablet
      fontSizeFactor = 0.032; // 3.2% for tablet
    } else {
      horizontalPaddingFactor = 0.04; // 4% for mobile
      verticalSpacingFactor = 0.02; // 2% for mobile
      fontSizeFactor = 0.04; // 4% for mobile
    }

    // Adjust for landscape orientation
    if (isLandscape && !isDesktop) {
      horizontalPaddingFactor *= 0.8;
      verticalSpacingFactor *= 0.7;
      fontSizeFactor *= 0.9;
    }

    final double horizontalPadding = screenWidth * horizontalPaddingFactor;
    final double verticalSpacing = screenWidth * verticalSpacingFactor;
    final double fontSize = screenWidth * fontSizeFactor;

    // Dynamic size constraints based on screen type
    final double minHorizontalPadding =
        isDesktop ? 16.0 : (isTablet ? 14.0 : 12.0);
    final double maxHorizontalPadding =
        isDesktop ? 24.0 : (isTablet ? 20.0 : 16.0);
    final double minVerticalSpacing =
        isDesktop ? 8.0 : (isTablet ? 10.0 : 12.0);
    final double maxVerticalSpacing =
        isDesktop ? 12.0 : (isTablet ? 14.0 : 16.0);
    final double minFontSize = isDesktop ? 16.0 : (isTablet ? 15.0 : 14.0);
    final double maxFontSize = isDesktop ? 20.0 : (isTablet ? 18.0 : 16.0);
    final double minLabelFontSize = isDesktop ? 18.0 : (isTablet ? 16.0 : 14.0);
    final double maxLabelFontSize = isDesktop ? 22.0 : (isTablet ? 20.0 : 18.0);

    // Dynamic border radius based on screen size
    final double dynamicBorderRadius =
        borderRadius ?? (isDesktop ? 8.0 : (isTablet ? 7.0 : 6.0));

    // Dynamic trailing spacing
    final double dynamicTrailingSpacing =
        trailingSpacing ?? (isDesktop ? 12.0 : (isTablet ? 10.0 : 8.0));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label text - only show if label is provided
        if (label != null)
          Padding(
            padding: EdgeInsets.only(
              bottom: verticalSpacing.clamp(
                minVerticalSpacing * 0.5,
                maxVerticalSpacing * 0.75,
              ),
            ),
            child: Text(
              label!,
              style:
                  labelStyle ??
                  TextStyle(
                    fontSize: fontSize.clamp(
                      minLabelFontSize,
                      maxLabelFontSize,
                    ),
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
            ),
          ),
        // Display container
        Container(
          width: double.infinity,
          height: height, // Apply height constraint if provided
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(dynamicBorderRadius),
            border: Border.all(
              color: borderColor ?? Colors.grey.shade300,
              width: isDesktop ? 1.5 : 1.0,
            ),
          ),
          padding:
              contentPadding ??
              EdgeInsets.symmetric(
                horizontal: horizontalPadding.clamp(
                  minHorizontalPadding,
                  maxHorizontalPadding,
                ),
                vertical: verticalSpacing.clamp(
                  minVerticalSpacing,
                  maxVerticalSpacing,
                ),
              ),
          child: Row(
            children: [
              // Main text content
              Expanded(
                child: Text(
                  value,
                  style:
                      valueStyle ??
                      TextStyle(
                        fontSize: fontSize.clamp(minFontSize, maxFontSize),
                        color: Colors.black87,
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: isDesktop ? 2 : 1,
                ),
              ),
              // Trailing widgets (buttons, icons, etc.)
              if (trailingWidgets != null && trailingWidgets!.isNotEmpty)
                Row(
                  mainAxisAlignment: trailingAlignment!,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < trailingWidgets!.length; i++) ...[
                      if (i > 0) SizedBox(width: dynamicTrailingSpacing),
                      // Wrap trailing widgets in flexible container for better responsiveness
                      Flexible(fit: FlexFit.loose, child: trailingWidgets![i]),
                    ],
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
