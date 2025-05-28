import 'package:flutter/material.dart';

class AllrewardsTabbar extends StatefulWidget {
  final List<String> tabTitles;
  final List<Widget> tabContents;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;

  const AllrewardsTabbar({
    super.key,
    required this.tabTitles,
    required this.tabContents,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
  }) : assert(
          tabTitles.length == tabContents.length,
          'Tab titles and contents must have the same length',
        );

  @override
  State<AllrewardsTabbar> createState() => _AllrewardsTabbarState();
}

class _AllrewardsTabbarState extends State<AllrewardsTabbar> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTabBar(),
        Expanded(child: widget.tabContents[_activeIndex]),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.backgroundColor ?? Colors.grey[100],
      ),
      child: Row(
        children: List.generate(
          widget.tabTitles.length,
          (index) => _buildTabItem(widget.tabTitles[index], index),
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    bool isActive = _activeIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _activeIndex = index;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isActive 
                ? (widget.activeColor ?? Colors.red[400]) 
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isActive 
                  ? Colors.white 
                  : (widget.inactiveColor ?? Colors.black87),
              fontSize: 14,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}