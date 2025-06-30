import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/endcustomer/controller/overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A stateless widget that displays an overview section with reactive data.
class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      OverviewController(),
    ); // Inject OverviewController
    final screenWidth = Get.width;

    // Calculate item width dynamically with minimum 100 width
    final itemWidth = (screenWidth - 40) / 3;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title bar with heading and settings icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText.heading('Overview', fontWeight: FontWeight.w700),

              InkWell(
                onTap: () {
                  // Handle the tap
                  print('Tune icon tapped');
                },
                borderRadius: BorderRadius.circular(
                  32,
                ), // Optional for ripple shape
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Icon(
                    Icons.tune,
                    color: Colors.grey[800], //Todo update color
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Wrap the Row in a SingleChildScrollView to avoid overflow on small devices
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() {
              // Build list of children with spacing
              List<Widget> children = [];
              final items = controller.items;

              for (int i = 0; i < items.length; i++) {
                final item = items[i];

                children.add(
                  SizedBox(
                    width: itemWidth < 100 ? 100 : itemWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Item Label
                        AppText.caption(
                          item.label,
                          fontWeight: FontWeight.w600,
                        ),

                        const SizedBox(height: 8),

                        // Icon and Values Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Icon inside a circular background
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(
                                0xFFFFF1D9,
                              ), //Todo update color
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Image.asset(
                                  item.iconPath,
                                  width: 24,
                                  height: 24,
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
                                  AppText.heading(
                                    item.value.toString(),
                                    fontWeight: FontWeight.w800,
                                  ),

                                  AppText.caption(
                                    item.subtitle,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );

                // Add horizontal spacing between items except last
                if (i != items.length - 1) {
                  children.add(const SizedBox(width: 16));
                }
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              );
            }),
          ),
        ],
      ),
    );
  }
}
