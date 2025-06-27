import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../viewModels/pharmacy_app/purchase/orderSummary_controller.dart';

class OrderCostSummaryCard extends StatefulWidget {
  final double medicineCost;
  final double creditPoints;
  final VoidCallback onViewPointsHistoryPressed;
  final VoidCallback onViewSummaryPressed;

  OrderCostSummaryCard({super.key, required this.onViewPointsHistoryPressed, required this.onViewSummaryPressed, required this.medicineCost, required this.creditPoints});

  @override
  State<OrderCostSummaryCard> createState() => _OrderCostSummaryCardState();
}

class _OrderCostSummaryCardState extends State<OrderCostSummaryCard> {
  final OrderSummaryController controller = Get.put(OrderSummaryController());

  @override
  void initState() {
    // TODO: implement initState
    controller.medicineCost.value = widget.medicineCost;
    controller.earnedPoints.value = widget.creditPoints;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Card(
        elevation: 0,
        color: Color.fromRGBO(252, 252, 252, 1),
        // margin: EdgeInsets.all(16),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Medicine Cost
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Estimated medicine cost', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                  Text('₹${controller.medicineCost.value.toStringAsFixed(2)}', style: TextStyle(fontSize: 14, color: Colors.black)),
                ],
              ),
              SizedBox(height: 8),

              // GST
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'GST on medicine (${controller.gstPercent.value.toStringAsFixed(0)}%)',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  Text('₹${controller.gstAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 14, color: Colors.black)),
                ],
              ),
              SizedBox(height: 8),

              Divider(thickness: 1, height: 24),

              // Total Cost
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total estimated cost + GST', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text('₹${controller.totalCost.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
              SizedBox(height: 16),

              // Credit Points Earned
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(

                    style: TextStyle(color: Colors.black, fontSize: 13),
                    children: [
                      TextSpan(text: 'Congratulation! You will earn '),
                      TextSpan(
                        text: '${controller.earnedPoints.value.toStringAsFixed(1)} \n',
                        style: TextStyle(color: LightThemeColors.main_pharmcay, fontWeight: FontWeight.bold ,fontSize: 18),
                      ),
                      TextSpan(text: 'Credit points on the order completion'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Column(
                  children: [
                    // Point Balance Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Your Point Balance', style: TextStyle(fontSize: 13, color: Colors.black87 ,fontWeight: FontWeight.w600)),
                        SizedBox(width: 4),
                        Icon(Icons.info_outline, size: 16, ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text(
                          controller.updatedPointBalance.toInt().toString(),
                          style: TextStyle(fontSize: 18, color:  LightThemeColors.main_pharmcay, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: widget.onViewPointsHistoryPressed,
                          child: Text(
                            'View points history.',
                            style: TextStyle(color: LightThemeColors.blue, fontSize: 13, decoration: TextDecoration.underline ,decorationColor: LightThemeColors.blue),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: widget.onViewSummaryPressed,
                      child: Text('View summary', style: TextStyle(color: Colors.blue, fontSize: 13, decoration: TextDecoration.underline ,decorationColor: LightThemeColors.blue)),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              Center(
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16 ,vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                      ),
                      backgroundColor: Colors.grey[300], foregroundColor: Colors.grey[700]),
                  child: Text('Send Request'),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
