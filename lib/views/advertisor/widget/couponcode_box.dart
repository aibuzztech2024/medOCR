import 'package:flutter/material.dart';

class CouponCodeBox extends StatelessWidget {
  final String couponCode;
  final VoidCallback? onCopy;

  const CouponCodeBox({
    super.key,
    required this.couponCode,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCopy,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.redAccent,
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
