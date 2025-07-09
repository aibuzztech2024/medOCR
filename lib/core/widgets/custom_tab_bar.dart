import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabTitles;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final double? indicatorWeight;
  final TabBarIndicatorSize? indicatorSize;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final EdgeInsetsGeometry? padding;

  const CustomTabBar({
    Key? key,
    required this.tabController,
    required this.tabTitles,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicatorWeight,
    this.indicatorSize,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16),
      child: TabBar(
        controller: tabController,
        indicatorColor: indicatorColor ?? Colors.red,
        indicatorWeight: indicatorWeight ?? 2,
        indicatorSize: indicatorSize ?? TabBarIndicatorSize.label,
        labelColor: labelColor ?? Colors.red,
        unselectedLabelColor: unselectedLabelColor ?? Colors.black,
        labelStyle:
            labelStyle ?? TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            unselectedLabelStyle ??
            TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        dividerColor: Colors.transparent,
        tabs: tabTitles.map((title) => Tab(text: title)).toList(),
      ),
    );
  }
}

class CustomTabBarView extends StatelessWidget {
  final TabController tabController;
  final List<Widget> children;

  const CustomTabBarView({
    Key? key,
    required this.tabController,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(controller: tabController, children: children);
  }
}

class CustomTabBarWithAppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final TabController tabController;
  final List<String> tabTitles;
  final List<Widget> tabViews;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final double? indicatorWeight;
  final TabBarIndicatorSize? indicatorSize;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final EdgeInsetsGeometry? tabBarPadding;
  final double? toolbarHeight;
  final Widget? leading;

  const CustomTabBarWithAppBar({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.tabController,
    required this.tabTitles,
    required this.tabViews,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicatorWeight,
    this.indicatorSize,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.tabBarPadding,
    this.toolbarHeight,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        toolbarHeight: toolbarHeight ?? 120,
        leading: null, // Remove leading
        leadingWidth: 0, // Remove leading width for perfect alignment
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        titleSpacing: 0, // Remove negative spacing
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTabBar(
              tabController: tabController,
              tabTitles: tabTitles,
              indicatorColor: indicatorColor,
              labelColor: labelColor,
              unselectedLabelColor: unselectedLabelColor,
              indicatorWeight: indicatorWeight,
              indicatorSize: indicatorSize,
              labelStyle: labelStyle,
              unselectedLabelStyle: unselectedLabelStyle,
              padding: EdgeInsets.zero, // Already wrapped in padding
            ),
          ),
        ),
      ),
      body: CustomTabBarView(tabController: tabController, children: tabViews),
    );
  }
}
