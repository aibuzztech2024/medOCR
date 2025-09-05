import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UpiPaymentComponent extends StatelessWidget {
  final List<UpiPaymentOption> paymentOptions;
  final VoidCallback? onAddNewUpiTap;
  final String title;

  const UpiPaymentComponent({
    Key? key,
    required this.paymentOptions,
    this.onAddNewUpiTap,
    this.title = "Pay by any UPI app",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Get.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Get.width * 0.04,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: Get.height * 0.02),

          // Payment options
          SizedBox(
            height: Get.height * 0.12,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: paymentOptions.length,
              itemBuilder: (context, index) {
                final option = paymentOptions[index];
                return Padding(
                  padding: EdgeInsets.only(right: Get.width * 0.04),
                  child: GestureDetector(
                    onTap: option.onTap,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: Get.width * 0.15,
                          height: Get.width * 0.15,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(child: _buildIcon(option)),
                        ),
                        SizedBox(height: Get.height * 0.008),
                        SizedBox(
                          width: Get.width * 0.18,
                          child: Text(
                            option.label,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Get.width * 0.03,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Add New UPI ID
          if (onAddNewUpiTap != null) ...[
            GestureDetector(
              onTap: onAddNewUpiTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, size: Get.width * 0.05, color: Colors.black),
                  SizedBox(width: Get.width * 0.02),
                  Text(
                    "Add New UPI ID",
                    style: TextStyle(
                      fontSize: Get.width * 0.035,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIcon(UpiPaymentOption option) {
    if (option.iconAsset != null) {
      // Use SVG asset
      return SvgPicture.asset(
        option.iconAsset!,
        width: Get.width * 0.08,
        height: Get.width * 0.08,
        colorFilter:
            option.iconColor != null
                ? ColorFilter.mode(option.iconColor!, BlendMode.srcIn)
                : null,
      );
    } else if (option.icon != null) {
      // Use Widget icon (for backward compatibility)
      return option.icon!;
    } else {
      // Fallback icon
      return Icon(Icons.payment, size: Get.width * 0.08, color: Colors.grey);
    }
  }
}

class UpiPaymentOption {
  final String label;
  final Widget? icon;
  final String? iconAsset;
  final Color? iconColor;
  final VoidCallback? onTap;

  UpiPaymentOption({
    required this.label,
    this.icon,
    this.iconAsset,
    this.iconColor,
    this.onTap,
  }) : assert(
         icon != null || iconAsset != null,
         'Either icon or iconAsset must be provided',
       );
}
