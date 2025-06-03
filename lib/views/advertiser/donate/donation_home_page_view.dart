// Fixed DonationHomePageView with proper SafeArea handling
import 'package:avatar/views/advertiser/donate/donation_controller.dart';
import 'package:avatar/views/advertiser/widget/donation_history_card.dart';
import 'package:avatar/views/advertiser/widget/donation_organization_card.dart';
import 'package:avatar/views/advertiser/widget/search_button.dart';
import 'package:avatar/views/advertiser/widget/view_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DonationHomePageView extends StatelessWidget {
  const DonationHomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrganizationController());

    return SafeArea(
      // ✅ Add SafeArea wrapper
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              // ✅ Add minimal top padding instead of status bar calculation
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildOrganizationTab(context, controller),
                    _buildDonationHistoryTab(context, controller),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      labelColor: const Color(0xFFFF6B6B),
      unselectedLabelColor: Colors.grey,
      dividerColor: Colors.transparent,
      indicatorColor: const Color(0xFFFF6B6B),
      indicatorWeight: 2,
      labelStyle: const TextStyle(
        fontSize: 16, // ✅ Use fixed size instead of Get.textScaleFactor
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      tabs: const [Tab(text: 'Organization'), Tab(text: 'Donation History')],
    );
  }

  Widget _buildOrganizationTab(
    BuildContext context,
    OrganizationController controller,
  ) {
    final double horizontalPadding =
        MediaQuery.of(context).size.width * 0.04; // ✅ Use MediaQuery

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ), // ✅ Context-based
              _buildOrganizationSearchBar(controller),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ],
          ),
        ),
        Expanded(
          child: _buildOrganizationList(context, controller, horizontalPadding),
        ),
      ],
    );
  }

  Widget _buildOrganizationSearchBar(OrganizationController controller) {
    return CustomSearchBar(
      prefixIcon: Icons.search,
      controller: controller.orgSearchController,
      onChanged: controller.onOrgSearchChanged,
      onSubmitted: controller.onOrgSearchSubmitted,
      padding: EdgeInsets.zero,
    );
  }

  Widget _buildOrganizationList(
    BuildContext context,
    OrganizationController controller,
    double horizontalPadding,
  ) {
    return Obx(() {
      if (controller.filteredOrganizations.isEmpty) {
        return _buildOrganizationEmptyState(controller);
      }

      return ListView.separated(
        // ✅ Use ListView.separated for better performance
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        itemCount: controller.filteredOrganizations.length,
        separatorBuilder:
            (context, index) => SizedBox(
              height:
                  MediaQuery.of(context).size.height *
                  0.015, // ✅ Context-based spacing
            ),
        itemBuilder: (context, index) {
          final organization = controller.filteredOrganizations[index];
          return OrganizationCard.fromModel(
            organization: organization,
            isBookmarked: false,
            onReadMore: () => controller.onReadMore(organization),
            onDonate: () => controller.onDonate(organization),
            onBookmarkToggle: null,
          );
        },
      );
    });
  }

  Widget _buildOrganizationEmptyState(OrganizationController controller) {
    return const Center(
      child: Text('No organizations found'), // ✅ Better empty state
    );
  }

  Widget _buildDonationHistoryTab(
    BuildContext context,
    OrganizationController controller,
  ) {
    final double horizontalPadding = MediaQuery.of(context).size.width * 0.04;
    return Column(
      children: [
        _buildHeaderSection(context, controller, horizontalPadding),
        Expanded(
          child: _buildScrollableContent(
            context,
            controller,
            horizontalPadding,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSection(
    BuildContext context,
    OrganizationController controller,
    double horizontalPadding,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ), // ✅ Context-based
          _buildSearchBar(controller),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          _buildControlsRow(controller),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ],
      ),
    );
  }

  Widget _buildSearchBar(OrganizationController controller) {
    return CustomSearchBar(
      prefixIcon: Icons.search,
      controller: controller.searchController,
      onChanged: controller.onSearchChanged,
      onSubmitted: controller.onSearchSubmitted,
      padding: EdgeInsets.zero,
    );
  }

  Widget _buildControlsRow(OrganizationController controller) {
    return Row(
      children: [
        Obx(
          () => ViewButton(
            options: controller.viewOptions,
            selectedOption: controller.selectedViewOption.value,
            onOptionSelected: controller.onViewOptionSelected,
          ),
        ),
        const Spacer(),
        _buildExportButton(),
        _buildBookmarkFilterButton(controller),
      ],
    );
  }

  Widget _buildExportButton() {
    return IconButton(
      onPressed: () {
        // TODO: Export functionality
      },
      icon: SvgPicture.asset('assets/icons/file_export.svg'),
      tooltip: 'Export data', // ✅ Add accessibility
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.grey.shade100),
        fixedSize: WidgetStateProperty.all(
          const Size(40, 40),
        ), // ✅ Larger touch target
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildBookmarkFilterButton(OrganizationController controller) {
    return Obx(
      () => IconButton(
        onPressed: controller.toggleBookmarkFilter,
        tooltip: 'Toggle bookmark filter', // ✅ Add accessibility
        icon: Icon(
          controller.showBookmarkedOnly.value
              ? Icons.bookmark
              : Icons.bookmark_border,
          color:
              controller.showBookmarkedOnly.value
                  ? const Color(0xFFFF6B6B)
                  : Colors.black,
        ),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.grey.shade100),
          fixedSize: WidgetStateProperty.all(
            const Size(40, 40),
          ), // ✅ Larger touch target
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableContent(
    BuildContext context,
    OrganizationController controller,
    double horizontalPadding,
  ) {
    return Obx(() {
      if (controller.filteredDonations.isEmpty) {
        return _buildEmptyState(controller);
      }
      return _buildDonationList(context, controller, horizontalPadding);
    });
  }

  Widget _buildDonationList(
    BuildContext context,
    OrganizationController controller,
    double horizontalPadding,
  ) {
    return ListView.separated(
      // ✅ Use ListView.separated
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      itemCount: controller.filteredDonations.length,
      separatorBuilder:
          (context, index) =>
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      itemBuilder: (context, index) {
        final donation = controller.filteredDonations[index];
        return Obx(
          () => DonationHistoryCard.fromModel(
            donation: donation,
            onTap: () => controller.onDonationTap(donation),
            isBookmarked: controller.isDonationBookmarked(donation),
            onBookmarkToggle: () => controller.toggleDonationBookmark(donation),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(OrganizationController controller) {
    return const Center(
      child: Text('No donations found'), // ✅ Better empty state
    );
  }
}
