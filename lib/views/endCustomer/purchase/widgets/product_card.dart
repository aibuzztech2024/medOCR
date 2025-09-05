import 'package:avatar/core/constants/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../models/endCustomer/purchase/product_modal.dart';

/// ProductCard widget displays a product in a card format.
/// It supports:
/// - Cart mode and normal mode
/// - Bookmarking toggle
///- Prescription received status

///  TODO  change color in  all

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onBookmarkToggle;
  final void Function(int quantity)? onAddToCart;

  const ProductCard({super.key, required this.product, this.onBookmarkToggle, this.onAddToCart});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isExpanded = false;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Color.fromRGBO(251, 253, 252, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.product.isRecommendation ? Colors.green : Colors.black54,
              borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
            ),
            child: Center(
              child: Text(widget.product.isRecommendation ? "Our Recommendation" : "You Searched", style: TextStyle(color: Colors.white)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: Colors.white,
                  elevation: 1,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Image.asset(widget.product.imageUrl, height: 110, fit: BoxFit.cover),
                          ),
                        ),

                        /// Bookmark Icon
                        Positioned(
                          top: -5,
                          right: -10,
                          // alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: widget.onBookmarkToggle,
                            icon: Icon(widget.product.isBookmarked ? Icons.bookmark : Icons.bookmark_border, color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(widget.product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),

                ///hidden details
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child:
                      isExpanded
                          ? Column(
                            spacing: 4,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              InfoRichRow(img: AppIcons.manufacture, title: "Manufacture", detail: widget.product.manufacturer),
                              InfoRichRow(img: AppIcons.packaging, title: "Packaging", detail: widget.product.packaging),
                              InfoRichRow(img: AppIcons.composition, title: "Salt Composition", detail: widget.product.saltComposition),
                              const SizedBox(height: 8),
                            ],
                          )
                          : const SizedBox.shrink(),
                ),

                const SizedBox(height: 8),

                /// Price Section
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('₹${widget.product.price}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text('MRP ₹${widget.product.mrp}', style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 0.5)),
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
                            child: Icon(Icons.remove, size: 22, color: Colors.black),
                          ),
                          const SizedBox(width: 6),
                          Text('$quantity', style: const TextStyle(fontWeight: FontWeight.w500)),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: Icon(Icons.add, size: 22, color: Colors.black),
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
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    // Expand/Collapse Button
                    InkWell(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Text(isExpanded ? "Less" : "More"),
                          Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.black, size: 20),
                        ],
                      ),
                    ),

                    Material(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: () {
                          if (widget.onAddToCart != null) {
                            widget.onAddToCart!(quantity);
                          }
                        },

                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
                          child: Text("Add to Cart", style: const TextStyle(fontSize: 14, color: Colors.white)),
                        ),
                      ),
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

class InfoRichRow extends StatelessWidget {
  final String img;
  final String title;
  final String detail;
  final Color? iconColor;

  const InfoRichRow({super.key, required this.img, required this.title, required this.detail, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(img, color: iconColor ?? Colors.black87, height: 20, width: 20),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              children: [
                TextSpan(text: "$title: ", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                TextSpan(text: detail, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black87)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
