import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5.5),
        height: 30,
        decoration: BoxDecoration(
          color: LightThemeColors.advertisorColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.body(
              couponCode,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            const Icon(Icons.copy, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}
