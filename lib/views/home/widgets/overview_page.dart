import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../viewModels/overview/overview_controller.dart';

/// A stateless widget that displays an overview section with reactive data.
class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OverviewController()); // Inject OverviewController
    final screenWidth = Get.width;

    // Ensure minimum width for each item, adjust spacing accordingly
    final itemWidth = (screenWidth - 40) / 3;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF8F8F8),
        toolbarHeight: 0, // Hides the AppBar space
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title bar with heading and settings icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Overview',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Handle the tap
                    print('Tune icon tapped');
                  },
                  borderRadius: BorderRadius.circular(32), // Optional for ripple shape
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 6, right: 10),
                    child: Icon(
                      Icons.tune,
                      color: Colors.grey[800], //Todo update color
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Reactive Row of Overview Cards
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: controller.items.map((item) {
                  return SizedBox(
                    width: itemWidth < 100 ? 100 : itemWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Item Label
                        Text(
                          item.label,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Icon and Values Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Icon inside a circular background
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(0xFFFFF1D9), //Todo update color
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Image.asset(
                                  item.iconPath,
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),

                            // Value and subtitle
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.value.toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item.subtitle,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
