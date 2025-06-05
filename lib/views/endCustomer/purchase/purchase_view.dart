
import 'package:avatar/views/endCustomer/purchase/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Product {
  final String imageUrl;
  final String name;
  final String type;
  final String dosage;
  final double price;
  final double mrp;
  final String quantity;
  final bool prescriptionReceived;
  final bool inCartMode;
  bool isBookmarked;

  Product({
    required this.imageUrl,
    required this.name,
    required this.type,
    required this.dosage,
    required this.price,
    required this.mrp,
    required this.quantity,
    required this.prescriptionReceived,
    required this.inCartMode,
    this.isBookmarked = false,
  });
}

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> dummyData = [
      Product(
        imageUrl: 'assets/images/tablet.png',
        name: 'Crocin Pain Relief Tablet 15’s',
        quantity: '60 Tablets',
        type: 'Pain Relief',
        dosage: '500 MG',
        price: 220,
        mrp: 245,
        prescriptionReceived: true,
        inCartMode: true,
      ),
      Product(
        imageUrl: 'assets/images/tablet.png',
        name: 'Crocin Pain Relief Tablet 15’s',
        quantity: '60 Tablets',
        type: 'Pain Relief',
        dosage: '500 MG',
        price: 220,
        mrp: 245,
        prescriptionReceived: false,
        inCartMode: false,
      ), Product(
        imageUrl: 'assets/images/tablet.png',
        name: 'Crocin Pain Relief Tablet 15’s',
        quantity: '60 Tablets',
        type: 'Pain Relief',
        dosage: '500 MG',
        price: 220,
        mrp: 245,
        prescriptionReceived: false,
        inCartMode: true,
      ), Product(
        imageUrl: 'assets/images/tablet.png',
        name: 'Crocin Pain Relief Tablet 15’s',
        quantity: '60 Tablets',
        type: 'Pain Relief',
        dosage: '500 MG',
        price: 220,
        mrp: 245,
        prescriptionReceived: true,
        inCartMode: false,
        isBookmarked: true
      ), Product(
        imageUrl: 'assets/images/tablet.png',
        name: 'Crocin Pain Relief Tablet 15’s',
        quantity: '60 Tablets',
        type: 'Pain Relief',
        dosage: '500 MG',
        price: 220,
        mrp: 245,
        prescriptionReceived: false,
        inCartMode: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: ListView.builder(
        itemCount: dummyData.length,
        itemBuilder: (context, index) {
          return ProductCard(product: dummyData[index]);
        },
      ),
    );
  }
}
