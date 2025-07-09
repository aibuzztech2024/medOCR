import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/coupon_card.dart';
import '../widgets/payment_info.dart'; // assume this exists

/// -------------------- MODEL --------------------
class CouponInfoModel {
  final String title;
  final String description;

  CouponInfoModel({
    required this.title,
    required this.description,
  });
}

/// -------------------- VIEW MODEL --------------------
class CouponInfoViewModel extends GetxController {
  final info = CouponInfoModel(
    title: 'Coupon',
    description:
    'Expand your reach with exclusive coupons for a targeted audience!',
  );
}

/// -------------------- MAIN PAGE --------------------
class CouponPayment extends StatelessWidget {
  CouponPayment({super.key});

  final CouponInfoViewModel controller = Get.put(CouponInfoViewModel());

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;
    final data = controller.info;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                data.title,
                style: TextStyle(
                  fontSize: width * 0.055,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: height * 0.01),

              /// Subtitle
              Text(
                data.description,
                style: TextStyle(
                  fontSize: width * 0.038,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),

              /// Coupon Card (self-contained)
              CouponCard(),

              SizedBox(height: height * 0.01),

              /// Payment Info (external widget)
              PaymentInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
