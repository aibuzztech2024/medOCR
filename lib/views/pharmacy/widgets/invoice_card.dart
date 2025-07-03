import 'package:flutter/material.dart';

/// Reusable Bill Image Component with text above
class InvoiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double? width;
  final double? height;

  const InvoiceCard({
    Key? key,
    this.imageUrl = "assets/images/bill.png",
    this.title = "Here is the final invoice, Thank you for your order.",
    this.width = 186,
    this.height = 213,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          /// Text above the image
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color.fromRGBO(75, 75, 75, 0.87),
            ),
          ),
          const SizedBox(height: 8),

          /// Bill Image with "View Sample" Overlay
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (_) => Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(imageUrl, fit: BoxFit.contain),
                      ),
                    ),
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  imageUrl,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: width,
                  height: height,
                  color: Colors.black.withOpacity(0.3),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.remove_red_eye, color: Colors.white, size: 32),
                      SizedBox(height: 8),
                      Text(
                        "View\nFinal Bill",
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
  }
}

/// Usage Example:
/// InvoiceCard(
///   imageUrl: "assets/images/bill.png",
///   title: "Here is the final invoice, Thank you for your order.",
///   width: 200,
///   height: 240,
/// )
