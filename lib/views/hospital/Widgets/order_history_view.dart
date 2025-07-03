import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../viewModels/hospital/order_history_controller.dart';
import '../../../widgets/cards/order_history_card.dart';

class OrderHistoryView extends StatelessWidget {
  final OrderHistoryController controller;

  const OrderHistoryView({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.orderHistoryList.isEmpty) {
        return const Center(child: Text("No orders found."));
      }

      return ListView.builder(
        itemCount: controller.orderHistoryList.length,
        itemBuilder: (context, index) {
          final order = controller.orderHistoryList[index];
          return OrderHistoryCard(
            order: order,
            onOrderAgain: () {
              Get.snackbar("Order", "Re-order placed successfully!");
            },
          );
        },
      );
    });
  }
}
