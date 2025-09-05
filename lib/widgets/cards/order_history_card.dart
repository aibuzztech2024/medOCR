import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/hospital/order_history_model.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text.dart';

class OrderHistoryCard extends StatelessWidget {
  final OrderHistoryModel order;
  final VoidCallback onOrderAgain;

  const OrderHistoryCard({
    Key? key,
    required this.order,
    required this.onOrderAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMMM y, hh:mm a');

    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Images
            Row(
              children:
                  order.imageUrls.map((url) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          url,
                          height: 48,
                          width: 48,
                          fit: BoxFit.contain,
                          errorBuilder:
                              (_, __, ___) => Container(
                                color: Colors.grey.shade100,
                                height: 48,
                                width: 48,
                                child: const Icon(
                                  Icons.image,
                                  color: Colors.grey,
                                ),
                              ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 18),
            // Status and price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AppText.heading("Order delivered", fontSize: 17),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                  ],
                ),
                AppText.heading("₹${order.price.toInt()}", fontSize: 18),
              ],
            ),
            const SizedBox(height: 6),
            AppText.body(
              "Placed on ${dateFormat.format(order.orderDate)}",
              color: Colors.grey[700],
              fontSize: 15,
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade300, height: 1),
            const SizedBox(height: 8),
            AppButton(
              type: ButtonType.text,
              text: "Order Again",
              onPressed: onOrderAgain,
              textColor: Colors.orange,
              borderRadius: 8,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ],
        ),
      ),
    );
  }
}
