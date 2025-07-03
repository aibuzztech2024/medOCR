import 'package:avatar/core/widgets/width_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../models/navigation/segment_tab_model.dart';
import '../../../viewModels/navigation/segment_controller.dart';
import '../../../core/widgets/app_text.dart';

class PerfectSegmentToggleWidget extends StatelessWidget {
  final List<SegmentTabModel> tabs;

  PerfectSegmentToggleWidget({super.key, required this.tabs}) {
    if (!Get.isRegistered<SegmentController>()) {
      Get.put(SegmentController());
    }
  }

  Widget _buildTab(SegmentTabModel tab, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? tab.activeColor : Colors.white,
            borderRadius: BorderRadius.horizontal(
              left:
                  tab == tabs.first ? const Radius.circular(8.0) : Radius.zero,
              right:
                  tab == tabs.last ? const Radius.circular(8.0) : Radius.zero,
            ),
            border:
                tab != tabs.last
                    ? const Border(
                      right: BorderSide(color: Colors.grey, width: 1.5),
                    )
                    : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (tab.iconData != null)
                Icon(
                  tab.iconData,
                  color: isSelected ? Colors.white : Colors.grey,
                  size: 20,
                )
              else if (tab.iconSvgPath != null)
                SvgPicture.asset(
                  tab.iconSvgPath!,
                  colorFilter: ColorFilter.mode(
                    isSelected ? Colors.white : Colors.grey,
                    BlendMode.srcIn,
                  ),
                  width: 20,
                  height: 20,
                ),
              const WidthBox(6),
              Flexible(
                child: AppText(
                  tab.label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SegmentController>();
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey, width: 1.5),
                ),
                child: Obx(
                  () => IntrinsicHeight(
                    child: Row(
                      children: List.generate(tabs.length, (index) {
                        final tab = tabs[index];
                        final isSelected =
                            controller.selectedIndex.value == index;
                        return _buildTab(
                          tab,
                          isSelected,
                          () => controller.changeIndex(index),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() => tabs[controller.selectedIndex.value].child),
          ),
        ],
      ),
    );
  }
}
