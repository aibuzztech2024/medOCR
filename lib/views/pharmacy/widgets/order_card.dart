import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui'; // FontFeature used in text styling

/// Model representing a pharmacy order
class OrderModel {
  final String shopName;
  final double rating;
  final String status;
  final double price;
  final String orderNo;
  final String imageUrl;
  final String distance;
  final String time;

  OrderModel({
    required this.shopName,
    required this.rating,
    required this.status,
    required this.price,
    required this.orderNo,
    required this.imageUrl,
    required this.distance,
    required this.time,
  });
}

/// ViewModel managing a reactive list of orders
class OrderViewModel extends GetxController {
  final orders = <OrderModel>[
    OrderModel(
      shopName: "Pharma Chemist",
      rating: 4.3,
      status: "Order Confirmed",
      price: 2425.0,
      orderNo: "#3454645",
      imageUrl: "assets/images/bill.png",
      distance: "6 km away",
      time: "30Mins",
    ),
  ].obs;
}

/// Order card widget list (can be reused as a component)
class OrderCardScreen extends StatelessWidget {
  final OrderViewModel vm = Get.put(OrderViewModel());

  @override
  Widget build(BuildContext context) {
    final width = Get.width;

    return Obx(() => ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vm.orders.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final order = vm.orders[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0x4D3AAFA9)),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            color: const Color(0x0D3AAFA9),
          ),

          /// Order Card Content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Row: Avatar + Shop Name + Rating + Distance + Time
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage('assets/images/medical_logo.jpg'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.shopName,
                          style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              order.rating.toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 4),
                            ...List.generate(5, (i) => Icon(
                              Icons.star,
                              size: 16,
                              color: i < order.rating.floor()
                                  ? Colors.teal
                                  : Colors.grey.shade300,
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        order.distance,
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.timer_outlined, size: 18, color: Colors.grey[700]),
                          const SizedBox(width: 4),
                          Text(order.time, style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Status & Price
              RichText(
                text: TextSpan(
                  text: 'Current Status: ',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                      text: order.status,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "₹${order.price.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),

              /// Order Number
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Order no : ',
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: order.orderNo,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              /// Bill Image with "View Sample" Overlay
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(order.imageUrl, fit: BoxFit.contain),
                      ),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      order.imageUrl,
                      width: 186,
                      height: 213,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: 186,
                      height: 213,
                      color: Colors.black.withOpacity(0.3),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.remove_red_eye, color: Colors.white, size: 32),
                          SizedBox(height: 8),
                          Text(
                            "View\nSample Bill",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
