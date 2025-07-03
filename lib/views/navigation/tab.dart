import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/widgets/app_text.dart';


class TabItem {
  final IconData icon;
  final String label;
  final Widget child;

  TabItem({required this.icon, required this.label, required this.child});
}

class CustomTabSwitcher extends StatelessWidget {
  final List<TabItem> tabs;
  final RxInt selectedIndex = 0.obs;

  CustomTabSwitcher({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(tabs.length, (index) {
                final isSelected = selectedIndex.value == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: GestureDetector(
                    onTap: () => selectedIndex.value = index,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade50 : Colors.white,
                        border: Border.all(
                          color:
                              isSelected
                                  ? Colors.blue.shade700
                                  : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            tabs[index].icon,
                            size: 18,
                            color:
                                isSelected ? Colors.blue.shade900 : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          AppText(
                            tabs[index].label,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color:
                                  isSelected
                                      ? Colors.blue.shade900
                                      : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Obx(
            () => SingleChildScrollView(child: tabs[selectedIndex.value].child),
          ),
        ),
      ],
    );
  }
}
