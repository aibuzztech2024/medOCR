import 'package:avatar/views/advertiser/donate/donation_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonationHistoryCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String status;
  final String dateTime;
  final String amount;
  final VoidCallback? onTap;
  final bool initialSaveState;
  final bool isBookmarked;
  final VoidCallback? onBookmarkToggle;

  const DonationHistoryCard({
    super.key,
    this.imageUrl,
    required this.title,
    required this.status,
    required this.dateTime,
    required this.amount,
    this.onTap,
    this.initialSaveState = false,
    this.isBookmarked = false,
    this.onBookmarkToggle,
  });

  // Alternative constructor that accepts DonationModel directly
  DonationHistoryCard.fromModel({
    super.key,
    required DonationModel donation,
    this.onTap,
    this.isBookmarked = false,
    this.onBookmarkToggle,
  }) : imageUrl = donation.imageUrl,
       title = donation.title,
       status = donation.status,
       dateTime = donation.dateTime,
       amount = donation.amount,
       initialSaveState = donation.initialSaveState;

  @override
  Widget build(BuildContext context) {
    final screenHeight = Get.height;
    final cardHeight = screenHeight * 0.087;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: IntrinsicHeight(
          child: Container(
            constraints: BoxConstraints(minHeight: cardHeight),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _buildImageSection(cardHeight),
                const SizedBox(width: 12),
                _buildContentSection(),
                const SizedBox(width: 8),
                _buildActionSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(double cardHeight) {
    final imageSize = cardHeight - 24;

    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(
        width: imageSize,
        height: imageSize,
        child: _buildImage(imageSize),
      ),
    );
  }

  Widget _buildImage(double size) {
    if (imageUrl?.isNotEmpty == true) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(size),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey[200],
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value:
                    loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
              ),
            ),
          );
        },
      );
    }
    return _buildPlaceholder(size);
  }

  Widget _buildPlaceholder(double size) {
    return Container(
      color: Colors.grey[200],
      child: Icon(Icons.person, color: Colors.grey[500], size: size * 0.5),
    );
  }

  Widget _buildContentSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          _buildStatusRow(),
          const SizedBox(height: 2),
          Text(
            dateTime,
            style: TextStyle(fontSize: 10, color: Colors.grey[500]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow() {
    return Row(
      children: [
        Text(
          'Status: ',
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
        Flexible(
          child: Text(
            status,
            style: TextStyle(
              fontSize: 10,
              color: _getStatusColor(),
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green[600]!;
      case 'pending':
        return Colors.orange[600]!;
      case 'failed':
        return Colors.red[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  Widget _buildActionSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onBookmarkToggle,
          child: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: isBookmarked ? const Color(0xFFFF6B6B) : Colors.grey[400],
            size: 24,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
