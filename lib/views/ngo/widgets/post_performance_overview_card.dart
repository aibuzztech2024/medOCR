import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Model class for post stats data
class PostStatsModel {
  final String title;
  final int count;
  final String duration;
  final String iconPath;

  PostStatsModel({
    required this.title,
    required this.count,
    required this.duration,
    required this.iconPath,
  });
}

/// ViewModel managing the post stats state
class PostStatsViewModel extends GetxController {
  final postStats = PostStatsModel(
    title: "Total Posts",
    count: 5,
    duration: "Last 30 days",
    iconPath: 'assets/icons/rupee.svg',
  ).obs;
}

/// PostPerformanceOverviewCard widget – responsive & dynamic card
class PostPerformanceOverviewCard extends StatelessWidget {
  final PostStatsViewModel vm = Get.put(PostStatsViewModel());
  final PostStatsModel? externalData;

  PostPerformanceOverviewCard({Key? key, this.externalData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Use external data if provided, else use ViewModel's data
    final data = externalData ?? vm.postStats.value;

    /// Split title into words for multi-line display
    final titleWords = data.title.split(' ');

    /// Calculate sizes relative to screen dimensions
    final screenWidth = Get.width;
    final screenHeight = Get.height;

    final containerWidth = screenWidth * 0.45;
    final containerHeight = screenHeight * 0.15;

    final iconBox = containerWidth * 0.22;
    final iconSize = iconBox * 0.6;

    final fontSizeTitle = containerWidth * 0.08;
    final fontSizeCount = containerWidth * 0.11;
    final fontSizeDuration = containerWidth * 0.045;

    /// Card container with border, rounded corners, and padding
    return Container(
      width: containerWidth,
      height: containerHeight,
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0x425182E3), // #5182E3 @ 26% opacity
          width: 1,
        ),
      ),

      /// Stack used for positioning icon at top-right
      child: Stack(
        children: [
          /// Icon container at top-right with rounded corners and background color
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: iconBox,
              height: iconBox,
              decoration: const BoxDecoration(
                color: Color(0xFFE8EEFF),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomLeft: Radius.circular(20),
                ),
              ),

              /// Centered SVG icon with color filter
              child: Center(
                child: SvgPicture.asset(
                  data.iconPath,
                  width: iconSize,
                  height: iconSize,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF5A6FF1),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),

          /// Column for title, count, and duration text arranged vertically
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              /// Title split by words, each word in its own Text widget
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: titleWords
                    .map(
                      (word) => Text(
                    word,
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: fontSizeTitle,
                      height: 1.2,
                      letterSpacing: 0,
                      color: Colors.black87,
                    ),
                  ),
                )
                    .toList(),
              ),

              /// Count text with bold and colored style
              Text(
                '${data.count}',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: fontSizeCount,
                  height: 1.2,
                  letterSpacing: 0,
                  color: const Color(0xFF6B79F5),
                ),
              ),

              /// Duration text with lighter weight and muted color
              Text(
                data.duration,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w400,
                  fontSize: fontSizeDuration,
                  height: 1.2,
                  letterSpacing: 0,
                  color: const Color(0xFF484848),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
