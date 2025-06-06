import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/card/card_model.dart';
import '../../../viewModels/card/card_view_model.dart';

class CardPage extends StatelessWidget {
  CardPage({Key? key}) : super(key: key);

  // Static list of cards for display
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          // Create and register CardViewModel with a unique tag for each card
          final controller = Get.put(CardViewModel(cards[index]), tag: 'card_$index');
          return ResponsiveCard(controller: controller);
        },
      ),
    );
  }
}

class ResponsiveCard extends StatelessWidget {
  final CardViewModel controller;

  const ResponsiveCard({required this.controller, Key? key}) : super(key: key);

  // Builds star rating icons based on the rating value
  List<Widget> buildStarRating(double rating) {
    return List<Widget>.generate(5, (index) {
      IconData icon;
      if (index < rating.floor()) {
        icon = Icons.star;
      } else if (index == rating.floor() && rating - rating.floor() >= 0.5) {
        icon = Icons.star_half;
      } else {
        icon = Icons.star_border;
      }
      return Icon(icon, size: 16, color: Colors.amber); //Todo update the color
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
        border: Border.all(color: Colors.grey, width: 1), //Todo update the color
      ),
      child: Obx(() {
        final data = controller.cardData;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Status and time ago row
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green, //Todo update the color
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

            // Image with loading and error handling
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                data.imageUrl.value,
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    height: imageHeight,
                    color: Colors.grey[300], //Todo update the color
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: imageHeight,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: Icon(Icons.broken_image, size: Get.width * 0.2, color: Colors.grey[700]), //Todo update the color
                  );
                },
              ),
            ),

            SizedBox(height: Get.height * 0.015),

            // Title, rating, and distance/ETA row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left Column: Title and Rating
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title.value,
                      style: TextStyle(
                        fontSize: Get.width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          data.rating.value.toStringAsFixed(1),
                          style: TextStyle(fontSize: Get.width * 0.035, color: Colors.black54),
                        ),
                        const SizedBox(width: 4),
                        Row(children: buildStarRating(data.rating.value)),
                      ],
                    ),
                  ],
                ),

                // Right Column: Distance and ETA
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data.distance.value,
                      style: TextStyle(fontSize: Get.width * 0.035, color: Colors.grey.shade700), //Todo update the color
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.timer_sharp, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          data.eta.value,
                          style: TextStyle(fontSize: Get.width * 0.035, color: Colors.grey.shade800), //Todo update the color
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),

            SizedBox(height: Get.height * 0.02),

            // Price and buttons row
            Row(
              children: [
                // Price Container
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.010),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE6C8), //Todo update the color
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

                // View Details Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, //Todo update the color
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

                // Accept Button (disabled if already accepted)
                Expanded(
                  child: Obx(() => ElevatedButton(
                    onPressed: data.isAccepted.value ? null : controller.accept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: data.isAccepted.value ? Colors.grey : Colors.green, //Todo update the color
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.010),
                    ),
                    child: Text(
                      data.isAccepted.value ? 'Accepted' : 'Accept',
                      style: TextStyle(color: Colors.white, fontSize: Get.width * 0.040),
                    ),
                  )),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
