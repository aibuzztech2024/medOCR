import 'package:avatar/core/widgets/height_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A custom scaffold widget that wraps a given [body] widget
/// and decorates it with positioned circular elements for
/// a visually appealing background.
///
/// The background includes:
/// - A large circle in the bottom-right
/// - A medium circle above the large one
/// - A small circle near the other two with different coloring
///
/// This widget also adapts to screen height using [context.height]
class AppScaffold extends StatelessWidget {
  /// The main content widget to be displayed at the center
  final Widget body;

  /// Weather to show BackButton or not
  /// Default to [true]
  final bool? showBackButton;

  /// Constructor for [AppScaffold]
  /// Takes a [body] widget as a required parameter
  /// The [body] will be centered and padded within the scaffold
  const AppScaffold({
    super.key,
    required this.body,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    // Screen-based sizes for circular elements
    final height = context.height;
    final largeCircle = height * 0.17; // 17% height of screen
    final mediumCircle = height * 0.072; // 0.72% height of screen
    final smallCircle = height * 0.042; // 0.42% of height of screen

    return Scaffold(
      body: Stack(
        children: [
          // Centered main content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: body,
          ),

          if (showBackButton!)
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: IconButton(
                  onPressed: Get.back,
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: context.theme.primaryColor,
                  ),
                ),
              ),
            ),

          // To make the stack expand and take full height of screen
          HeightBox(height),

          // Decorative Large Circle
          Positioned(
            bottom: -5,
            right: -(largeCircle * 0.3),
            child: BuildCircle(
              size: largeCircle,
              color: context.theme.primaryColor.withOpacity(0.1),
            ),
          ),

          // Decorative Medium Circle
          Positioned(
            bottom: largeCircle * 0.07,
            right: largeCircle - (largeCircle * 0.2),
            child: BuildCircle(
              size: mediumCircle,
              color: context.theme.colorScheme.secondary.withOpacity(0.1),
            ),
          ),

          // Decorative Small Circle
          Positioned(
            bottom: -smallCircle * 0.4,
            right: largeCircle - (largeCircle * 0.15) + mediumCircle,
            child: BuildCircle(
              size: smallCircle,
              color: Colors.amber.withOpacity(0.15),
            ),
          ),
        ],
      ),
    );
  }
}

/// Utility method to create circular containers
class BuildCircle extends StatelessWidget {
  final double size;
  final Color color;
  const BuildCircle({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
