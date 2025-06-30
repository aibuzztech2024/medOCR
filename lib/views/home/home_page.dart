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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 18,
              children: [

                AddressSelector(),
                Payment_Method_Selector_widget(),
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}
