import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/map/mao_view_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectableChip extends StatelessWidget {
  final MapViewDataController mapViewDataController;
  final int index;
  const SelectableChip({
    super.key,
    required this.mapViewDataController,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var isFirst = index == 0;
      var isLast = index == mapViewDataController.labels.length - 1;
      var isSelected =
          mapViewDataController.selectedLabel.value ==
          mapViewDataController.labels[index];
      return Expanded(
        child: Padding(
          // White gaps between two chips
          padding: EdgeInsets.only(right: isLast ? 0 : 3),
          child: InkWell(
            onTap:
                () =>
                    mapViewDataController.selectedLabel.value =
                        mapViewDataController.labels[index],
            child: AnimatedContainer(
              duration: Durations.medium1,
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? context.theme.primaryColor
                        : Colors.grey.shade400,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(isFirst ? 10 : 0),
                  right: Radius.circular(isLast ? 10 : 0),
                ),
              ),
              child: SizedBox(
                height: 40,
                child: Center(
                  child: AppText.body(
                    mapViewDataController.labels[index],
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
