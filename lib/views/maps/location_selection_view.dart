import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'location_selection_viewmodel.dart';
import 'components/location_selection_header.dart';
import 'components/empty_state_widget.dart';
import 'components/default_locations_list.dart';
import 'components/search_results_list.dart';

class LocationSelectionView extends StatelessWidget {
  const LocationSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(LocationSelectionViewModel());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Header with back button and search inputs
            LocationSelectionHeader(
              onBackPressed: () {
                Navigator.pop(context);
              },
              onSwapPressed: viewModel.onSwapPressed,
              startLocationController: viewModel.startLocationController,
              destinationController: viewModel.destinationController,
              onStartLocationChanged: viewModel.onStartLocationChanged,
              onDestinationChanged: viewModel.onDestinationChanged,
            ),

            Divider(height: 1, thickness: 1, color: Colors.grey[300]),

            // Location suggestions list
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: Colors.white,
                child: Obx(() {
                  // Show loading state for either search
                  if (viewModel.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // If there are search results, show them
                  if (viewModel.hasSearchResults) {
                    return SearchResultsList(
                      results: viewModel.activeResults,
                      isStartLocation: viewModel.isStartLocationActive,
                      onLocationSelected: viewModel.onLocationSelected,
                    );
                  }

                  // If search is active but no results found
                  if (viewModel.isSearchActive) {
                    return const EmptyStateWidget();
                  }

                  // If no search is active, show default locations
                  return DefaultLocationsList(
                    defaultLocations: viewModel.defaultLocations,
                    onCurrentLocationTap: viewModel.onCurrentLocationTap,
                    onMoreHistoryTap: viewModel.onMoreHistoryTap,
                    onLocationTap: viewModel.onLocationTap,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for dashed line
class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.grey[400]!
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    const dashHeight = 3.0;
    const dashSpace = 2.0;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
