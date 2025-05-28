// =============================================================================
// VIEW LAYER - Updated DonationHomePageView with Fixed Navigation Binding
// =============================================================================
import 'package:avatar/views/advertiser/donate/donation_controller.dart';
import 'package:avatar/views/advertiser/widget/donation_history_card.dart';
import 'package:avatar/views/advertiser/widget/donation_organization_card.dart';
import 'package:avatar/views/advertiser/widget/search_button.dart';
import 'package:avatar/views/advertiser/widget/view_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

/// [VIEW] Main page widget - Pure UI component following MVVM pattern
class DonationHomePageView extends StatelessWidget {
  const DonationHomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      OrganizationController(),
    ); // Inject controller (ViewModel)

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: Get.height * 0.08), // Top spacing for status bar
            _buildTabBar(), // Tab bar UI
            Expanded(
              child: TabBarView(
                children: [
                  _buildOrganizationTab(
                    controller,
                  ), // Organization tab (simplified)
                  _buildDonationHistoryTab(controller), // Donation history tab
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tab bar styling
  Widget _buildTabBar() {
    return TabBar(
      labelColor: const Color(0xFFFF6B6B),
      unselectedLabelColor: Colors.grey,
      dividerColor: Colors.transparent,
      indicatorColor: const Color(0xFFFF6B6B),
      indicatorWeight: 2,
      labelStyle: TextStyle(
        fontSize: Get.textScaleFactor * 16,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: Get.textScaleFactor * 16,
        fontWeight: FontWeight.w500,
      ),
      tabs: const [Tab(text: 'Organization'), Tab(text: 'Donation History')],
    );
  }

  // Organization tab - simplified with only search functionality
  Widget _buildOrganizationTab(OrganizationController controller) {
    final double horizontalPadding = Get.width * 0.04;

    return Column(
      children: [
        // Header section with only search bar
        Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.02),
              _buildOrganizationSearchBar(controller), // Search bar only
              SizedBox(height: Get.height * 0.02),
            ],
          ),
        ),
        // Scrollable organization list
        Expanded(child: _buildOrganizationList(controller, horizontalPadding)),
      ],
    );
  }

  // Organization search bar (no filter buttons)
  Widget _buildOrganizationSearchBar(OrganizationController controller) {
    return CustomSearchBar(
      prefixIcon: Icons.search,
      controller:
          controller.orgSearchController, // Bind to org search controller
      onChanged: controller.onOrgSearchChanged, // Live search binding
      onSubmitted: controller.onOrgSearchSubmitted, // Search submission
      padding: EdgeInsets.zero,
    );
  }

  // Organization list with simplified cards (no bookmark functionality)
  Widget _buildOrganizationList(
    OrganizationController controller,
    double horizontalPadding,
  ) {
    return Obx(() {
      if (controller.filteredOrganizations.isEmpty) {
        return _buildOrganizationEmptyState(controller); // Show empty state
      }

      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        itemCount:
            controller.filteredOrganizations.length, // Reactive list length
        itemBuilder: (context, index) {
          final organization = controller.filteredOrganizations[index];
          return Column(
            children: [
              OrganizationCard.fromModel(
                organization: organization, // Data binding
                isBookmarked: false, // No bookmark functionality
                onReadMore:
                    () =>
                        controller.onReadMore(organization), // Read more action
                onDonate:
                    () => controller.onDonate(organization), // Donate action
                onBookmarkToggle: null, // No bookmark toggle
              ),
              SizedBox(height: Get.height * 0.015), // Spacing between cards
            ],
          );
        },
      );
    });
  }

  // Empty state for organization tab (simplified)
  Widget _buildOrganizationEmptyState(OrganizationController controller) {
    return const SizedBox.shrink();
  }

  // Donation history tab (full functionality with filters and bookmarks)
  Widget _buildDonationHistoryTab(OrganizationController controller) {
    final double horizontalPadding = Get.width * 0.04;
    return Column(
      children: [
        _buildHeaderSection(
          controller,
          horizontalPadding,
        ), // Header with search & controls
        Expanded(
          child: _buildScrollableContent(
            controller,
            horizontalPadding,
          ), // Main content
        ),
      ],
    );
  }

  // Header section for donation history (search + filter controls)
  Widget _buildHeaderSection(
    OrganizationController controller,
    double horizontalPadding,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          SizedBox(height: Get.height * 0.02), // Top spacing
          _buildSearchBar(controller), // Search input
          SizedBox(height: Get.height * 0.02),
          _buildControlsRow(controller), // View and filter controls
          SizedBox(height: Get.height * 0.02),
        ],
      ),
    );
  }

  // Search bar for donation history
  Widget _buildSearchBar(OrganizationController controller) {
    return CustomSearchBar(
      prefixIcon: Icons.search,
      controller:
          controller.searchController, // Bind to donation search controller
      onChanged: controller.onSearchChanged, // Live search binding
      onSubmitted: controller.onSearchSubmitted, // Search submission
      padding: EdgeInsets.zero,
    );
  }

  // Controls row with view options and bookmark filter
  Widget _buildControlsRow(OrganizationController controller) {
    return Row(
      children: [
        Obx(
          () => ViewButton(
            options:
                controller
                    .viewOptions, // Filter options (all/completed/pending)
            selectedOption:
                controller.selectedViewOption.value, // Current selection
            onOptionSelected: controller.onViewOptionSelected, // Update logic
          ),
        ),
        const Spacer(), // Push buttons to right
        _buildExportButton(), // Export icon
        _buildBookmarkFilterButton(controller), // Toggle bookmark filter
      ],
    );
  }

  Widget _buildExportButton() {
    return IconButton(
      onPressed: () {
        // TODO: Export functionality
      },
      icon: SvgPicture.asset('assets/icons/file_export.svg'),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.grey.shade100),
        fixedSize: WidgetStateProperty.all(const Size(20, 20)),
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
          fixedSize: WidgetStateProperty.all(const Size(20, 20)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableContent(
    OrganizationController controller,
    double horizontalPadding,
  ) {
    return Obx(() {
      if (controller.filteredDonations.isEmpty)
        return _buildEmptyState(controller);
      return _buildDonationList(
        controller,
        horizontalPadding,
      ); // Donations available
    });
  }

  Widget _buildDonationList(
    OrganizationController controller,
    double horizontalPadding,
  ) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      itemCount:
          controller.filteredDonations.length, // Dynamic length from ViewModel
      itemBuilder: (context, index) {
        final donation = controller.filteredDonations[index];
        return Column(
          children: [
            Obx(
              () => DonationHistoryCard.fromModel(
                donation: donation, // Data binding
                // UPDATED: Pass the donation object to the tap handler
                onTap:
                    () => controller.onDonationTap(
                      donation,
                    ), // Fixed navigation binding
                isBookmarked: controller.isDonationBookmarked(donation),
                onBookmarkToggle:
                    () => controller.toggleDonationBookmark(donation),
              ),
            ),
            SizedBox(height: Get.height * 0.01), // Spacing between cards
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(OrganizationController controller) {
    return const SizedBox.shrink();
  }
}
