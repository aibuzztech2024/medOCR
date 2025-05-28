// =============================================================================
// VIEW LAYER - OrganizationCard Widget (Clean MVVM Implementation)
// =============================================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar/views/advertiser/donate/donation_model.dart';

/// [VIEW] Organization card widget following MVVM architecture
/// Displays organization information using the extended DonationModel
class OrganizationCard extends StatelessWidget {
  // Data binding from ViewModel
  final DonationModel organization;

  // Action callbacks to ViewModel
  final VoidCallback? onReadMore;
  final VoidCallback? onDonate;
  final VoidCallback? onBookmarkToggle;

  // UI state from ViewModel
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
    return _buildCard();
  }

  Widget _buildCard() {
    // Get dynamic sizing based on screen dimensions
    final screenWidth = Get.width;
    final screenHeight = Get.height;

    // Calculate responsive dimensions (maintaining aspect ratio from original)
    final cardWidth = screenWidth * (366 / 402);
    final cardHeight =
        screenHeight * (140 / 874); // Slightly taller for organization info
    final imageWidth = screenWidth * (100 / 402);

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: _buildCardDecoration(),
      child: Row(
        children: [
          _buildImageSection(imageWidth, cardHeight),
          _buildContentSection(cardWidth, cardHeight, imageWidth),
        ],
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: Colors.deepOrange.shade100,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
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
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: cardWidth * 0.035,
          vertical: cardHeight * 0.08,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleSection(cardWidth, cardHeight),
            SizedBox(height: cardHeight * 0.02),
            _buildLocationSection(cardWidth, cardHeight),
            SizedBox(height: cardHeight * 0.02),
            _buildActionSection(cardWidth, cardHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection(double cardWidth, double cardHeight) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              organization.title,
              style: TextStyle(
                fontSize: (cardWidth * 0.038).clamp(12.0, 16.0),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2D3748),
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (organization.address != null) ...[
            SizedBox(height: cardHeight * 0.01),
            Flexible(
              child: Text(
                organization.address!,
                style: TextStyle(
                  fontSize: (cardWidth * 0.033).clamp(10.0, 14.0),
                  color: const Color(0xFF718096),
                  fontWeight: FontWeight.w400,
                  height: 1.1,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLocationSection(double cardWidth, double cardHeight) {
    return Container(
      height: cardHeight * 0.15,
      child: Row(
        children: [
          if (organization.distance != null) ...[
            Icon(
              Icons.location_on,
              size: (cardWidth * 0.035).clamp(12.0, 16.0),
              color: const Color(0xFF718096),
            ),
            SizedBox(width: cardWidth * 0.01),
            Flexible(
              child: Text(
                organization.distance!,
                style: TextStyle(
                  fontSize: (cardWidth * 0.033).clamp(10.0, 14.0),
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
              margin: EdgeInsets.symmetric(horizontal: cardWidth * 0.015),
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
                style: TextStyle(
                  fontSize: (cardWidth * 0.033).clamp(10.0, 14.0),
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

  Widget _buildActionSection(double cardWidth, double cardHeight) {
    return Container(
      height: cardHeight * 0.25,
      child: Row(
        children: [
          _buildAmountDisplay(cardWidth),
          _buildDivider(cardWidth, cardHeight),
          _buildReadMoreButton(cardWidth),
          const Spacer(),
          _buildDonateButton(cardWidth, cardHeight),
        ],
      ),
    );
  }

  Widget _buildAmountDisplay(double cardWidth) {
    return Text(
      organization.amount,
      style: TextStyle(
        fontSize: (cardWidth * 0.049).clamp(16.0, 20.0),
        color: const Color(0xFFFF6B6B),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildDivider(double cardWidth, double cardHeight) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: cardWidth * 0.02),
      width: 1,
      height: cardHeight * 0.15,
      color: const Color(0xFFFF6B6B),
    );
  }

  Widget _buildReadMoreButton(double cardWidth) {
    return GestureDetector(
      onTap: onReadMore,
      child: Text(
        'Read More',
        style: TextStyle(
          fontSize: (cardWidth * 0.033).clamp(10.0, 14.0),
          color: const Color(0xFFFF6B6B),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildDonateButton(double cardWidth, double cardHeight) {
    return GestureDetector(
      onTap: onDonate,
      child: Container(
        constraints: BoxConstraints(
          minHeight: cardHeight * 0.2,
          maxHeight: cardHeight * 0.25,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: cardWidth * 0.04,
          vertical: cardHeight * 0.04,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFF6B6B),
          borderRadius: BorderRadius.circular(
            (cardWidth * 0.05).clamp(12.0, 20.0),
          ),
        ),
        child: Center(
          child: Text(
            'Donate Now',
            style: TextStyle(
              fontSize: (cardWidth * 0.038).clamp(12.0, 16.0),
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
