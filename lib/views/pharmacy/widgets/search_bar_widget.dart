import 'package:flutter/material.dart';
import 'package:get/get.dart';


/// Model for medicine search filter UI
class MedicineSearchModel {
  final String searchHint;
  final String viewText;
  final IconData expandIcon;
  final IconData exportIcon;
  final IconData bookmarkIcon;

  MedicineSearchModel({
    required this.searchHint,
    required this.viewText,
    required this.expandIcon,
    required this.exportIcon,
    required this.bookmarkIcon,
  });
}


/// Controller to manage medicine search data and state
class MedicineSearchController extends GetxController {
  final model = MedicineSearchModel(
    searchHint: 'Search by medicine name or categories',
    viewText: 'View',
    expandIcon: Icons.expand_more,
    exportIcon: Icons.open_in_new,
    bookmarkIcon: Icons.bookmark_border,
  ).obs;
}

class MedicineSearchBar extends StatelessWidget {
  const MedicineSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller if not already registered
    final controller = Get.put(MedicineSearchController());

    // Responsive units
    final double screenWidth = Get.width;
    final double screenHeight = Get.height;
    final double padding = screenWidth * 0.04;
    final double iconSize = screenWidth * 0.06;
    final double fontSize = screenWidth * 0.035;
    final double buttonSize = screenWidth * 0.13;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.04), // Top spacing

          /// Search bar container
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: padding * 0.7,
              vertical: screenHeight * 0.015,
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey, size: iconSize),
                SizedBox(width: screenWidth * 0.02),

                /// Search hint text
                Expanded(
                  child: Obx(() => Text(
                    controller.model.value.searchHint,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: fontSize,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )),
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          /// View + icons row
          Row(
            children: [
              Obx(() => Text(
                controller.model.value.viewText,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.black87,
                ),
              )),
              Icon(controller.model.value.expandIcon, size: iconSize),

              const Spacer(),

              /// Export
              _roundedIconButton(
                icon: controller.model.value.exportIcon,
                size: buttonSize,
                iconSize: iconSize,
              ),

              SizedBox(width: screenWidth * 0.02),

              /// Bookmark
              _roundedIconButton(
                icon: controller.model.value.bookmarkIcon,
                size: buttonSize,
                iconSize: iconSize,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Reusable rounded icon button
  Widget _roundedIconButton({
    required IconData icon,
    required double size,
    required double iconSize,
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: iconSize, color: Colors.black87),
    );
  }
}
