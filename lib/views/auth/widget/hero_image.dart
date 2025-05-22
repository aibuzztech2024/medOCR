import 'package:avatar/core/constants/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';

/// This widget shows hero image
/// It can be displayed on top of the [auth] screens i.e. [Login] & [Register]
class HeroImage extends StatelessWidget {
  /// The image is having padding of [sideMargin] + [38]
  ///
  /// The image is having [BoxFit.contain] to fit the image in the available space.
  ///
  /// The image is having [Center] widget to center the image in the available space.
  ///
  /// To adjust [Height] and [Width] wrap this widget with [SizedBox]
  const HeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        // Padding of 19 on left and right side
        // Padding of 10 on top and 15 on bottom
        // [Left] [Top] [Right] [Bottom]
        padding: EdgeInsets.fromLTRB(19, 10, 19, 5),
        child: Hero(
          tag: 'AuthHeroImage',
          child: Image.asset(
            // Image path is imported from [image_paths.dart]
            ImagePaths.loginRegisterHeaderImage,
            fit: BoxFit.contain,
            height: context.height * 0.25, // 25% of screen height
          ),
        ),
      ),
    );
  }
}
