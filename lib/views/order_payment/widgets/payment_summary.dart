import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSummary extends StatelessWidget {
  final String title;
  final List<PaymentItem> items;
  final PaymentItem totalItem;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? borderRadius;
  final TextStyle? titleStyle;
  final TextStyle? itemLabelStyle;
  final TextStyle? itemValueStyle;
  final TextStyle? totalLabelStyle;
  final TextStyle? totalValueStyle;

  const PaymentSummary({
    Key? key,
    required this.title,
    required this.items,
    required this.totalItem,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.titleStyle,
    this.itemLabelStyle,
    this.itemValueStyle,
    this.totalLabelStyle,
    this.totalValueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using GetX for responsive design
    final screenHeight = Get.height;
    final screenWidth = Get.width;

    // Responsive padding and spacing using GetX
    final responsivePadding = screenWidth < 360 ? 8.0 : 12.0;

    return Container(
      padding: padding ?? EdgeInsets.all(responsivePadding),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            title,
            style:
                titleStyle ??
                TextStyle(
                  fontSize: Get.width < 360 ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          // Flexible space for content
          SizedBox(height: screenHeight < 600 ? 4.0 : 8.0),

          // Payment items section - Using Flexible instead of Expanded
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Payment items
                ...items.map(
                  (item) => Padding(
                    padding: EdgeInsets.only(
                      bottom: screenHeight < 600 ? 2.0 : 4.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.label,
                            style:
                                itemLabelStyle ??
                                TextStyle(
                                  fontSize: Get.width < 360 ? 12 : 13,
                                  color: Colors.grey[700],
                                  height: 1.2,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          item.value,
                          style:
                              itemValueStyle ??
                              TextStyle(
                                fontSize: Get.width < 360 ? 12 : 13,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),

                // Spacing before total
                SizedBox(height: screenHeight < 600 ? 4.0 : 8.0),

                // Total item with emphasis
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        totalItem.label,
                        style:
                            totalLabelStyle ??
                            TextStyle(
                              fontSize: Get.width < 360 ? 14 : 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              height: 1.2,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      totalItem.value,
                      style:
                          totalValueStyle ??
                          TextStyle(
                            fontSize: Get.width < 360 ? 14 : 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            height: 1.2,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentItem {
  final String label;
  final String value;

  const PaymentItem({required this.label, required this.value});
}
