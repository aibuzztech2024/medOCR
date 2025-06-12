import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import for SvgPicture
import '../../models/navigation/segment_tab_model.dart';
import '../../viewModels/navigation/segment_controller.dart';

class PerfectSegmentToggleWidget extends StatelessWidget {
  final List<SegmentTabModel> tabs;

  PerfectSegmentToggleWidget({required this.tabs});

  final SegmentController controller = Get.put(SegmentController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey, width: 1.5),
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(tabs.length, (index) {
                  final tab = tabs[index];
                  final isSelected = controller.selectedIndex.value == index;

                  return GestureDetector(
                    onTap: () {
                      controller.changeIndex(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? tab.activeColor : Colors.white,
                        borderRadius: BorderRadius.horizontal(
                          left:
                              index == 0
                                  ? const Radius.circular(8.0)
                                  : Radius.zero,
                          right:
                              index == tabs.length - 1
                                  ? const Radius.circular(8.0)
                                  : Radius.zero,
                        ),
                        border:
                            index < tabs.length - 1
                                ? const Border(
                                  right: BorderSide(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                )
                                : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Conditionally render Icon or SvgPicture
                          if (tab.iconData != null)
                            Icon(
                              tab.iconData,
                              color: isSelected ? Colors.white : Colors.grey,
                              size: 24,
                            )
                          else if (tab.iconSvgPath != null)
                            SvgPicture.asset(
                              tab.iconSvgPath!,
                              colorFilter: ColorFilter.mode(
                                isSelected ? Colors.white : Colors.grey,
                                BlendMode.srcIn,
                              ),
                              width: 24, // Adjust size as needed
                              height: 24, // Adjust size as needed
                            ),
                          const SizedBox(width: 8),
                          Text(
                            tab.label,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.visible,
                            softWrap: false,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 10),
          tabs[controller.selectedIndex.value].child,
        ],
      ),
    );
  }
}
