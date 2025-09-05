// =============================================================================
// FIXED APPROACH - Dynamic Layout with Proper Overflow Handling
// =============================================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar/views/advertiser/donate/donation_model.dart';
import 'package:avatar/core/widgets/app_button.dart';

/// [VIEW] Organization card widget with dynamic responsive design
class OrganizationCard extends StatelessWidget {
  final DonationModel organization;
  final VoidCallback? onReadMore;
  final VoidCallback? onDonate;
  final VoidCallback? onBookmarkToggle;
  final bool isBookmarked;

  const OrganizationCard({
    Key? key,
    required this.organization,
    this.onReadMore,
    this.onDonate,
    this.onBookmarkToggle,
    this.isBookmarked = false,
  }) : super(key: key);

  /// Factory constructor for easy integration with ViewModel
  factory OrganizationCard.fromModel({
    required DonationModel organization,
    VoidCallback? onReadMore,
    VoidCallback? onDonate,
    VoidCallback? onBookmarkToggle,
    bool isBookmarked = false,
  }) => OrganizationCard(
    organization: organization,
    onReadMore: onReadMore,
    onDonate: onDonate,
    onBookmarkToggle: onBookmarkToggle,
    isBookmarked: isBookmarked,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildCard(constraints);
      },
    );
  }

  Widget _buildCard(BoxConstraints constraints) {
    // Dynamic dimension calculations with better responsiveness
    final screenWidth = Get.width;
    final screenHeight = Get.height;

    // More adaptive sizing based on available space
    final cardWidth = (constraints.maxWidth > 0
            ? constraints.maxWidth
            : screenWidth * 0.9104)
        .clamp(300.0, 500.0);
    final cardHeight = (screenHeight * 0.16).clamp(120.0, 180.0);
    final imageWidth = cardWidth * 0.27; // Adjusted ratio for better balance

    return Stack(
      children: [
        Container(
          width: cardWidth,
          height: cardHeight,
          decoration: _buildCardDecoration(),
          child: Row(
            children: [
              _buildImageSection(imageWidth, cardHeight),
              _buildContentSection(cardWidth, cardHeight, imageWidth),
            ],
          ),
        ),
        _buildRightSideSemicircle(cardWidth, cardHeight),
      ],
    );
  }

  Widget _buildRightSideSemicircle(double cardWidth, double cardHeight) {
    final radius = (cardHeight * 0.15).clamp(20.0, 40.0);

    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        width: radius,
        height: radius * 2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomLeft: Radius.circular(radius),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: Colors.deepOrange.shade100,
      borderRadius: BorderRadius.circular(12),
    );
  }

  Widget _buildImageSection(double imageWidth, double cardHeight) {
    return Container(
      width: imageWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
        image: DecorationImage(
          image: NetworkImage(organization.imageUrl ?? ''),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {
            // Handle image loading errors gracefully
          },
        ),
      ),
    );
  }

  Widget _buildContentSection(
    double cardWidth,
    double cardHeight,
    double imageWidth,
  ) {
    final contentWidth = cardWidth - imageWidth;

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(cardHeight * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTitleSection(contentWidth, cardHeight),
            _buildLocationSection(contentWidth, cardHeight),
            _buildActionSection(contentWidth, cardHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection(double contentWidth, double cardHeight) {
    return Flexible(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Use FittedBox to scale down long titles instead of wrapping
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              organization.title,
              style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2D3748),
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.visible,
            ),
          ),
          if (organization.address != null) ...[
            SizedBox(height: cardHeight * 0.01),
            Text(
              organization.address!,
              style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                height: 1.1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLocationSection(double contentWidth, double cardHeight) {
    return Flexible(
      child: Row(
        children: [
          if (organization.distance != null) ...[
            Icon(
              Icons.location_on,
              size: Theme.of(Get.context!).textTheme.labelSmall?.fontSize ?? 10,
              color: const Color(0xFF718096),
            ),
            SizedBox(width: contentWidth * 0.01),
            Flexible(
              child: Text(
                organization.distance!,
                style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFF718096),
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          if (organization.distance != null &&
              organization.category != null) ...[
            Container(
              margin: EdgeInsets.symmetric(horizontal: contentWidth * 0.02),
              width: 3,
              height: 3,
              decoration: const BoxDecoration(
                color: Color(0xFF718096),
                shape: BoxShape.circle,
              ),
            ),
          ],
          if (organization.category != null) ...[
            Flexible(
              child: Text(
                organization.category!,
                style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFF718096),
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionSection(double contentWidth, double cardHeight) {
    return Row(
      children: [
        // Amount and Read More section - takes available space
        Expanded(
          child: Row(
            children: [
              _buildAmountDisplay(contentWidth),
              _buildDivider(contentWidth, cardHeight),
              _buildReadMoreButton(contentWidth),
            ],
          ),
        ),
        // Fixed spacing
        SizedBox(width: contentWidth * 0.02),
        // Donate button - fixed size
        _buildDonateButton(contentWidth, cardHeight),
      ],
    );
  }

  Widget _buildAmountDisplay(double contentWidth) {
    return Text(
      '₹${organization.amount}',
      style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(
        color: const Color(0xFFFF6B6B),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDivider(double contentWidth, double cardHeight) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: contentWidth * 0.025),
      width: 1,
      height: 16,
      color: const Color(0xFFFF6B6B),
    );
  }

  Widget _buildReadMoreButton(double contentWidth) {
    return GestureDetector(
      onTap: onReadMore,
      child: Text(
        'Read More',
        style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
          decoration: TextDecoration.underline,
          decorationColor: const Color(0xFFFF6B6B),
          color: const Color(0xFFFF6B6B),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildDonateButton(double contentWidth, double cardHeight) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 70, maxWidth: contentWidth * 0.35),
      child: AppButton(
        type: ButtonType.filled,
        onPressed: onDonate,
        color: const Color(0xFFFF6B6B),
        height: 30,
        borderRadius: 8,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Donate Now',
            style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  /// Helper method to calculate responsive font sizes
  double _getResponsiveFontSize(
    double width,
    double baseSize,
    double minSize,
    double maxSize,
  ) {
    double scaleFactor = (width / 200).clamp(0.8, 1.4);
    return (baseSize * scaleFactor).clamp(minSize, maxSize);
  }
}
