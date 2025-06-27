import 'package:flutter/material.dart';

import '../../models/endCustomer/purchase/product_modal.dart';
import '../endCustomer/purchase/widgets/myCart_productCard.dart';
import '../pharmacy_app/purchase/widgets/Order_CostSummary_Card.dart';
import '../pharmacy_app/purchase/widgets/select_Payment_method_widget.dart';
import '../pharmacy_app/purchase/widgets/select_delivery_address_widget.dart';
import '../pharmacy_app/settings/widgets/delete_profile_dailog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 18,
              children: [
                OrderCostSummaryCard(
                  onViewPointsHistoryPressed: () {
                    print('View points history tapped');
                  },
                  onViewSummaryPressed: () {
                    print('View summary tapped');
                  },
                  medicineCost: 244.5,
                  creditPoints: 12.5,
                ),

                AddressSelector(),
                Payment_Method_Selector_widget(),
                ElevatedButton(onPressed: () => showDeleteProfileDialog(context), child: Text("Delete Profile")),

                MyCart_ProductCard(
                  product: Product(
                    imageUrl: 'assets/images/tablet.png',
                    name: 'Crocin Pain Relief Tablet',
                    price: 220,
                    mrp: 245,
                    quantity: '60 Tablets',
                    manufacturer: 'ABC Pharmaceuticals',
                    prescriptionReceived: false,
                    isBookmarked: false,
                    packaging: 'Bottle',
                    saltComposition: 'Paracetamol (650mg), Caffeine (50mg)',
                    isRecommendation: true,
                  ),
                ),
                MyCart_ProductCard(
                  product: Product(
                    imageUrl: 'assets/images/tablet.png',
                    name: 'Crocin ',
                    price: 120,
                    mrp: 345,
                    quantity: '60 Tablets',
                    manufacturer: 'ABC Pharmaceuticals',
                    prescriptionReceived: false,
                    isBookmarked: false,
                    packaging: 'Bottle',
                    saltComposition: 'Paracetamol (650mg), Caffeine (50mg)',
                    isRecommendation: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
