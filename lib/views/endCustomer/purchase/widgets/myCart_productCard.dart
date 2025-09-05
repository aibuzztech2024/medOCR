import 'package:avatar/core/constants/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../models/endCustomer/purchase/product_modal.dart';

///  TODO  change color in  all

class MyCart_ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onClose;

  const MyCart_ProductCard({super.key, required this.product, this.onClose});

  @override
  State<MyCart_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<MyCart_ProductCard> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: context.theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 251, 245, 1),
              borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
            ),

            child: Row(
              spacing: 12,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Image.asset(widget.product.imageUrl, fit: BoxFit.cover, height: 60, width: 60),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black38, width: 0.5),
                            ),
                            child: SvgPicture.asset(AppIcons.close, color: Colors.black87, height: 12),
                          ),
                        ],
                      ),
                      Text(widget.product.manufacturer, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('MRP ', style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                    Text(
                      '₹${widget.product.mrp.toInt()}',
                      style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, decoration: TextDecoration.lineThrough),
                    ),
                    const SizedBox(width: 8),

                    Text(  getDiscountPercent(widget.product.mrp, widget.product.price),
                        style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500)),
                  ],
                ),

                /// Price Section
                Row(
                  spacing: 8,
                  children: [
                    Text('₹${widget.product.price.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.grey.shade400),

                      child: Text(widget.product.quantity, style: TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                    Spacer(),

                    ///qunatity
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.orange),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                            child: Icon(Icons.remove, size: 24, color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          Text('$quantity', style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18)),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: Icon(Icons.add, size: 24, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Container(
                  color: Colors.green.shade50,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 18),
                      const Text("  Prescription Recieved", style: TextStyle(color: Colors.green, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
