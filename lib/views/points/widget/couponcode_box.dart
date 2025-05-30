import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:flutter/material.dart';


//this is the row container the a text and the coupon code
class CouponCodeBox extends StatelessWidget {
  final String couponCode;
  final VoidCallback? onCopy;

  const CouponCodeBox({super.key, required this.couponCode, this.onCopy});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCopy,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: LightThemeColors.advertisorColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              couponCode,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.copy, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
