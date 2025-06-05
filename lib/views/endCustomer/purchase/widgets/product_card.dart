import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../purchase_view.dart';
//TO-DO  CHANGE COLOR OF WHOLE FILE
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: Center(child: Image.asset(product.imageUrl, width: 70, height: 70, fit: BoxFit.cover))),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!product.inCartMode) const Text("Prescription required", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(product.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(product.quantity, style: const TextStyle(fontSize: 12)),
                      const SizedBox(height: 6),
                      Row(children: [_tag(product.type), const SizedBox(width: 6), _tag(product.dosage)]),
                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('₹${product.price}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              Text('MRP ₹${product.mrp}', style: const TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough)),
                            ],
                          ),
                          Spacer(),
                          if (product.inCartMode)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(width: 0.5)),
                              child: Row(
                                children: [Icon(Icons.remove), const SizedBox(width: 4), const Text("1"), const SizedBox(width: 4), Icon(Icons.add)],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      product.inCartMode
                          ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),

                              color: product.prescriptionReceived ? Colors.green.shade50 : Colors.orange.shade50,
                            ),
                            child: Row(
                              spacing: 4,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  product.prescriptionReceived ? Icons.check_circle : Icons.cancel,
                                  color: product.prescriptionReceived ? Colors.green : Colors.orange,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    product.prescriptionReceived ? "Prescription received" : "Prescription not received, Upload below",
                                    style: TextStyle(fontSize: 12, color: product.prescriptionReceived ? Colors.green : Colors.orange),
                                  ),
                                ),
                                if (product.prescriptionReceived) Icon(Icons.remove_red_eye_outlined, size: 16, color: Colors.black),
                                if (product.prescriptionReceived) Icon(CupertinoIcons.delete, size: 16, color: Colors.red),
                              ],
                            ),
                          )
                          : Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
                              child: Text("Add to Cart", style: const TextStyle(fontSize: 18, color: Colors.white)),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
              if (!product.inCartMode)  Icon(product.isBookmarked ?Icons.bookmark:  Icons.bookmark_border, color: Colors.orange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tag(String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(color: Colors.orange[100], borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.orange)),
  );
}
