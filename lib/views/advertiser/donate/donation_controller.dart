// =============================================================================
// VIEWMODEL LAYER - Updated OrganizationController with Read More Navigation
// =============================================================================

import 'package:avatar/views/advertiser/donate/donation_detailed_read_more.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar/views/advertiser/donate/donation_model.dart';
import 'package:avatar/views/advertiser/donate/donation_details_page.dart';
import 'package:avatar/views/advertiser/widget/view_button.dart';

/// [CONTROLLER] Manages both donation history and organization states
/// Handles navigation, search, filtering, and bookmarking functionality
class OrganizationController extends GetxController {
  // =============================================================================
  // UI INPUT CONTROLLERS
  // =============================================================================

  /// Search controller for donation history tab
  final TextEditingController searchController = TextEditingController();

  /// Search controller for organization tab
  final TextEditingController orgSearchController = TextEditingController();

  // =============================================================================
  // REACTIVE STATE - DONATION HISTORY
  // =============================================================================

  /// Current search query for donations
  final RxString searchQuery = ''.obs;

  /// Selected filter type (all/completed/pending)
  final RxString selectedFilter = 'all'.obs;

  /// Currently selected view option
  final Rx<ViewOption> selectedViewOption =
      const ViewOption(label: 'All', value: 'all').obs;

  /// Whether to show only bookmarked donations
  final RxBool showBookmarkedOnly = false.obs;

  // =============================================================================
  // REACTIVE STATE - ORGANIZATION (SIMPLIFIED)
  // =============================================================================

  /// Current search query for organizations
  final RxString orgSearchQuery = ''.obs;

  // =============================================================================
  // DATA MANAGEMENT - SINGLE SOURCE FOR BOTH TABS
  // =============================================================================

  /// Master data source containing all donation/organization records
  final RxList<DonationModel> allDonations = <DonationModel>[].obs;

  /// Filtered donations for donation history tab
  final RxList<DonationModel> filteredDonations = <DonationModel>[].obs;

  /// Filtered organizations for organization tab
  final RxList<DonationModel> filteredOrganizations = <DonationModel>[].obs;

  /// Set of bookmarked donation titles (donations tab only)
  final RxSet<String> bookmarkedDonations = <String>{}.obs;

  // =============================================================================
  // VIEW CONFIGURATION - DONATION HISTORY OPTIONS
  // =============================================================================

  /// Available filter options for donation history
  final List<ViewOption> viewOptions = const [
    ViewOption(label: 'All', value: 'all', icon: Icons.list),
    ViewOption(
      label: 'Completed',
      value: 'completed',
      icon: Icons.check_circle,
    ),
    ViewOption(label: 'Pending', value: 'pending', icon: Icons.pending),
  ];

  // =============================================================================
  // LIFECYCLE METHODS
  // =============================================================================

  @override
  void onInit() {
    super.onInit();
    _loadInitialData(); // Load sample data
    _setupReactiveListeners(); // Setup reactive filtering
    _applyFilters(); // Apply initial donation filters
    _applyOrganizationFilters(); // Apply initial organization filters
  }

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    searchController.dispose();
    orgSearchController.dispose();
    super.onClose();
  }

  // =============================================================================
  // INITIALIZATION METHODS
  // =============================================================================

  /// Load sample data and initialize bookmark state for donations only
  void _loadInitialData() {
    allDonations.value = DonationData.getSampleDonations();

    // Initialize bookmark states only for donation history
    for (var donation in allDonations) {
      if (donation.initialSaveState) {
        bookmarkedDonations.add(donation.title);
      }
    }
  }

  /// Set up reactive filtering for both donation and organization tabs
  void _setupReactiveListeners() {
    // Donation search listener
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });

    // Organization search listener
    orgSearchController.addListener(() {
      orgSearchQuery.value = orgSearchController.text;
    });

    // Donation filters - includes bookmarks and status filters
    everAll([
      searchQuery,
      selectedFilter,
      showBookmarkedOnly,
      bookmarkedDonations,
    ], (_) => _applyFilters());

    // Organization filters - only search (no bookmarks or status filters)
    ever(orgSearchQuery, (_) => _applyOrganizationFilters());
  }

  // =============================================================================
  // FILTERING METHODS
  // =============================================================================

  /// Apply active filters to donation list (includes bookmarks and status)
  void _applyFilters() {
    List<DonationModel> result = allDonations.toList();

    // Apply bookmark filter if enabled
    if (showBookmarkedOnly.value) {
      result =
          result.where((d) => bookmarkedDonations.contains(d.title)).toList();
    }

    // Apply status filter
    if (selectedFilter.value != 'all') {
      result =
          result
              .where(
                (d) =>
                    d.status.toLowerCase() ==
                    selectedFilter.value.toLowerCase(),
              )
              .toList();
    }

    // Apply search filter
    if (searchQuery.value.isNotEmpty) {
      result =
          result
              .where(
                (d) => d.title.toLowerCase().contains(
                  searchQuery.value.toLowerCase(),
                ),
              )
              .toList();
    }

    filteredDonations.value = result;
  }

  /// Apply search filter to organization list (simplified - no bookmarks or status filters)
  void _applyOrganizationFilters() {
    List<DonationModel> result = allDonations.toList();

    // Only apply search filter for organizations
    if (orgSearchQuery.value.isNotEmpty) {
      final query = orgSearchQuery.value.toLowerCase();
      result =
          result
              .where(
                (org) =>
                    org.title.toLowerCase().contains(query) ||
                    (org.address?.toLowerCase().contains(query) ?? false) ||
                    (org.category?.toLowerCase().contains(query) ?? false),
              )
              .toList();
    }

    filteredOrganizations.value = result;
  }

  // =============================================================================
  // UI EVENT HANDLERS - FILTER & SEARCH
  // =============================================================================

  /// Handle filter dropdown selection (donation history only)
  void onViewOptionSelected(ViewOption option) {
    selectedViewOption.value = option;
    selectedFilter.value = option.value;
  }

  /// Handle search input changes - Donations
  void onSearchChanged(String value) => searchQuery.value = value;

  /// Handle search submission - Donations
  void onSearchSubmitted(String value) => searchQuery.value = value;

  /// Handle search input changes - Organizations
  void onOrgSearchChanged(String value) => orgSearchQuery.value = value;

  /// Handle search submission - Organizations
  void onOrgSearchSubmitted(String value) => orgSearchQuery.value = value;

  // =============================================================================
  // UI EVENT HANDLERS - NAVIGATION
  // =============================================================================

  /// Handle donation card tap - Navigate to basic donation details
  void onDonationTap(DonationModel donation) {
    print('Donation card tapped: ${donation.title}');
    _navigateToDonationDetails(donation);
  }

  /// Handle organization card tap - General organization interaction
  void onOrganizationTap(DonationModel organization) {
    print('Organization tapped: ${organization.title}');
    // Could implement different behavior for organization tap vs read more
    // For now, we'll navigate to detailed view as well
  }

  /// Handle read more action - Navigate to DonationCardReadMorePage with organization data
  void onReadMore(DonationModel organization) {
    print('Read more clicked for: ${organization.title}');
    _navigateToReadMorePage(organization);
  }

  /// Handle donate action for organizations
  void onDonate(DonationModel organization) {
    print('Donate button clicked for: ${organization.title}');
    // TODO: Navigate to donation flow/payment page
    Get.snackbar(
      'Donate',
      'Donation flow for ${organization.title} will be implemented',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFFF6B6B).withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  // =============================================================================
  // NAVIGATION METHODS
  // =============================================================================

  /// Navigate to basic donation detail page (for donation history)
  void _navigateToDonationDetails(DonationModel item) {
    try {
      Get.to(
        () => DonationDetailView(donation: item),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );
    } catch (e) {
      print('Navigation error to DonationDetailView: $e');
      Get.snackbar(
        'Navigation Error',
        'Unable to open donation details',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  /// Navigate to DonationCardReadMorePage with organization data
  void _navigateToReadMorePage(DonationModel organization) {
    try {
      // Pass the organization data as arguments to the next page
      Get.to(
        () => const DonationCardReadMorePage(),
        arguments: organization, // Pass the selected organization data
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );
    } catch (e) {
      print('Navigation error to DonationCardReadMorePage: $e');
      Get.snackbar(
        'Navigation Error',
        'Unable to open organization details',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  // =============================================================================
  // BOOKMARK METHODS - DONATIONS ONLY
  // =============================================================================

  /// Toggle bookmark status for a donation
  void toggleDonationBookmark(DonationModel donation) {
    if (bookmarkedDonations.contains(donation.title)) {
      bookmarkedDonations.remove(donation.title);
    } else {
      bookmarkedDonations.add(donation.title);
    }
  }

  /// Check if a donation is bookmarked
  bool isDonationBookmarked(DonationModel donation) =>
      bookmarkedDonations.contains(donation.title);

  /// Toggle the bookmark filter on/off
  void toggleBookmarkFilter() =>
      showBookmarkedOnly.value = !showBookmarkedOnly.value;

  // =============================================================================
  // DATA UTILITY METHODS
  // =============================================================================

  /// Refresh donation data and reapply filters
  void refreshDonations() {
    allDonations.value = DonationData.getSampleDonations();
    _applyFilters(); // Refresh donation filters
    _applyOrganizationFilters(); // Refresh organization filters
  }

  /// Refresh organization filters only
  void refreshOrganizations() {
    _applyOrganizationFilters(); // Only refresh search filter
  }

  /// Clear donation search
  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  /// Clear organization search
  void clearOrgSearch() {
    orgSearchController.clear();
    orgSearchQuery.value = '';
  }

  /// Reset all donation filters to default
  void resetFilters() {
    selectedFilter.value = 'all';
    selectedViewOption.value = const ViewOption(label: 'All', value: 'all');
    showBookmarkedOnly.value = false;
    clearSearch();
  }

  /// Reset organization filters to default
  void resetOrgFilters() {
    clearOrgSearch(); // Only clear search for organizations
  }

  // =============================================================================
  // STATISTICS METHODS
  // =============================================================================

  /// Get donation status counts for analytics
  Map<String, int> getStatusCounts() {
    final all = allDonations.length;
    final completed =
        allDonations.where((d) => d.status.toLowerCase() == 'completed').length;
    final pending =
        allDonations.where((d) => d.status.toLowerCase() == 'pending').length;
    return {'all': all, 'completed': completed, 'pending': pending};
  }

  /// Get organization statistics
  Map<String, int> getOrganizationStats() {
    final all =
        allDonations.length; // Total organizations (using same data source)
    return {'all': all}; // Simplified stats - no bookmark/nearby filters
  }
}
