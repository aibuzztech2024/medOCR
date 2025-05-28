import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonationCardModel1 {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String distance;
  final String category;
  final String description;
  final String websiteUrl;

  DonationCardModel1({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.distance,
    required this.category,
    required this.description,
    required this.websiteUrl,
  });
}

class DonationCard extends StatelessWidget {
  final DonationCardModel1 donation;

  const DonationCard({Key? key, required this.donation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 366,
      height: 364,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container
          Container(
            width: 366,
            height: 255,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              image: DecorationImage(
                image: NetworkImage(donation.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Content Container
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        donation.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D3748),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: Get.height * 0.001),

                      // Description
                      Text(
                        donation.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF718096),
                          height: 1.4,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
