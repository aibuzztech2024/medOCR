import 'package:avatar/viewModels/endcustomerhome/controller/end_customer_appbar_controller.dart';
import 'package:avatar/core/widgets/endcustomer_appbar.dart';
import 'package:avatar/views/endcustomerhome/widget/feature_reward_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EndCustomerAppbarController());

    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),

      ///TODO change accoring to req
      appBar: EndcustomerAppbar(),

      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // widget for scrollable coupons list for homepage
            
            
            FeatureRewardsWidget(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
