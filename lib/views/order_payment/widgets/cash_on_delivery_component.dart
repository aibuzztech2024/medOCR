import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PaymentOptionComponent extends StatelessWidget {
  final String iconAsset;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;

  const PaymentOptionComponent({
    Key? key,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    this.isSelected = false,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFE0E0E0),
    this.borderRadius = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: Get.height * 0.09, // Dynamic height (~72px responsive)
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04,
          vertical: Get.height * 0.012,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: Get.width * 0.12, // Responsive icon container
              height: Get.width * 0.12,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconAsset,
                  width: Get.width * 0.06,
                  height: Get.width * 0.06,
                ),
              ),
            ),
            SizedBox(width: Get.width * 0.03),
            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: Get.width * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.002),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: Get.width * 0.032,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Radio button
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: Get.width * 0.06,
                height: Get.width * 0.06,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 1),
                  color: isSelected ? Colors.blue : Colors.transparent,
                ),
                child:
                    isSelected
                        ? Center(
                          child: Container(
                            width: Get.width * 0.025,
                            height: Get.width * 0.025,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        )
                        : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
