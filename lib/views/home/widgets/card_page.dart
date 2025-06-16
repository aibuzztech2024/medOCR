import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/card/card_model.dart';
import '../../../viewModels/card/card_view_model.dart';

class CardPage extends StatelessWidget {
  CardPage({Key? key}) : super(key: key);

  // Static list of card data for demonstration
  final List<CardModel> cards = [
    CardModel(
      title: 'Pharma Chemist',
      imageUrl: 'https://images.unsplash.com/photo-1604145942179-63cd583fcf64?w=900',
      rating: 4.3,
      distance: '6 km away',
      eta: '30 Mins',
      price: '₹2,425',
      timeAgo: '5 mins ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling for inner list
      shrinkWrap: true, // Make ListView only take needed height inside parent
      itemCount: cards.length,
      itemBuilder: (context, index) {
        // Create a controller instance for each card with a unique tag
        final controller = Get.put(CardViewModel(cards[index]), tag: 'card_$index');
        // Build the UI card widget using the controller
        return ResponsiveCard(controller: controller);
      },
    );
  }
}

class ResponsiveCard extends StatelessWidget {
  final CardViewModel controller;

  const ResponsiveCard({required this.controller, Key? key}) : super(key: key);

  // Builds star rating icons based on the rating value (full, half, empty stars)
  List<Widget> buildStarRating(double rating) {
    return List<Widget>.generate(5, (index) {
      IconData icon;
      if (index < rating.floor()) {
        icon = Icons.star; // Full star for integer rating part
      } else if (index == rating.floor() && rating - rating.floor() >= 0.5) {
        icon = Icons.star_half; // Half star if decimal >= 0.5
      } else {
        icon = Icons.star_border; // Empty star otherwise
      }
      return Icon(icon, size: 16, color: Colors.amber);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Responsive dimensions based on screen size
    final double cardWidth = Get.width * 0.9;
    final double cardPadding = Get.width * 0.03;
    final double imageHeight = Get.height * 0.15;

    return Container(
      width: cardWidth,
      margin: EdgeInsets.all(cardPadding),
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F2), // Light cream background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Obx(() {
        // Reactive rebuild when any observable property changes in controller
        final data = controller.cardData;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Status dot and "time ago" label
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green, // Online/active indicator
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: Get.width * 0.015),
                Text(
                  data.timeAgo.value,
                  style: TextStyle(fontSize: Get.width * 0.035, color: Colors.black87),
                ),
              ],
            ),

            SizedBox(height: Get.height * 0.012),

            // Image with rounded corners, loading spinner, and error placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                data.imageUrl.value,
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child; // Image loaded
                  return Container(
                    height: imageHeight,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  // Show icon if image fails to load
                  return Container(
                    height: imageHeight,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: Icon(Icons.broken_image, size: Get.width * 0.2, color: Colors.grey[700]),
                  );
                },
              ),
            ),

            SizedBox(height: Get.height * 0.015),

            // Title, rating, distance, and estimated time of arrival (ETA)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side: Title and rating with stars
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title.value,
                      style: TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          data.rating.value.toStringAsFixed(1), // e.g. 4.3
                          style: TextStyle(fontSize: Get.width * 0.035, color: Colors.black54),
                        ),
                        const SizedBox(width: 4),
                        Row(children: buildStarRating(data.rating.value)), // Star icons
                      ],
                    ),
                  ],
                ),
                // Right side: Distance and ETA
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data.distance.value,
                      style: TextStyle(fontSize: Get.width * 0.035, color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.timer_sharp, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          data.eta.value,
                          style: TextStyle(fontSize: Get.width * 0.035, color: Colors.grey.shade800),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),

            SizedBox(height: Get.height * 0.02),

            // Bottom row with price and action buttons
            Row(
              children: [
                // Price badge with orange background
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.010),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE6C8),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      data.price.value,
                      style: TextStyle(fontSize: Get.width * 0.04, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                SizedBox(width: Get.width * 0.04),

                // "View Details" button in orange color
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement view details action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.010),
                    ),
                    child: Text(
                      'View Details',
                      style: TextStyle(color: Colors.white, fontSize: Get.width * 0.038),
                    ),
                  ),
                ),

                SizedBox(width: Get.width * 0.04),

                // "Accept" button in green color (no action assigned here)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement accept action or disable button
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.010),
                    ),
                    child: Text(
                      'Accept',
                      style: TextStyle(color: Colors.white, fontSize: Get.width * 0.040),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
