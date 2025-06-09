import 'package:avatar/views/reward/widget/feature_reward_widget.dart';
import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),

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
