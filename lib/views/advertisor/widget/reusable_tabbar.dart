import 'package:avatar/viewModels/advertisor/tabbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReusableTabbar extends StatelessWidget {
  final List<String> tabTitles;
  final List<Widget> tabContents;

  ReusableTabbar({
    super.key,
    required this.tabTitles,
    required this.tabContents,
  }) : assert(
         tabTitles.length == tabContents.length,
         'Tab titles and contents must have the same length',
       );

  final ScrollController _scrollController = ScrollController();
  final TabbarController controller = Get.put(TabbarController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTabBar(),
        Expanded(child: Obx(() => tabContents[controller.activeIndex.value])),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            tabTitles.length,
            (index) => Obx(() => _buildTabItem(tabTitles[index], index)),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    bool isActive = controller.activeIndex.value == index;

    return InkWell(
      onTap: () {
        controller.setActiveIndex(index);
        _scrollToActiveTab(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? Colors.red[400]! : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isActive ? Colors.red[400] : Colors.grey[600],
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _scrollToActiveTab(int index) {
    if (_scrollController.hasClients) {
      double tabWidth = 120.0;
      double screenWidth = Get.width;
      double targetOffset =
          (index * tabWidth) - (screenWidth / 2) + (tabWidth / 2);

      double maxScrollExtent = _scrollController.position.maxScrollExtent;
      double clampedOffset = targetOffset.clamp(0.0, maxScrollExtent);

      _scrollController.animateTo(
        clampedOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
