import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// -------------------- MODEL --------------------
class HealthOfferModel {
  final String title;
  final String subtitle;
  final String tag;
  final String imagePath;

  HealthOfferModel({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.imagePath,
  });
}

/// -------------------- VIEW MODEL --------------------
class HealthOfferViewModel extends GetxController {
  final offer = HealthOfferModel(
    title: 'Summer Mega Offer',
    subtitle:
    'Complete health assessment including blood work, cardiac evaluation, and nutritionist consultation',
    tag: 'COUPON',
    imagePath: 'assets/images/pills.jpg',
  );
}

/// -------------------- COUPON CARD --------------------
class CouponCard extends StatelessWidget {
  CouponCard({super.key});

  final HealthOfferViewModel controller = Get.put(HealthOfferViewModel());

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;
    final offer = controller.offer;

    return Container(
      width: width * 0.9,
      margin: EdgeInsets.symmetric(
        vertical: height * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(8, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(width * 0.03),
            ),
            child: Image.asset(
              offer.imagePath,
              width: 366,
              height: 234,
              fit: BoxFit.cover,
            ),
          ),

          /// Text content
          Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer.tag,
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: Color(0xFFFF6F61),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: height * 0.005),
                Text(
                  offer.title,
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: height * 0.007),
                Text(
                  offer.subtitle,
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
