import 'package:avatar/views/advertisor/points.dart';
import 'package:avatar/views/advertisor/claimrewards.dart';
import 'package:avatar/views/advertisor/points_history.dart';
import 'package:avatar/views/advertisor/transactional_screen.dart';
import 'package:avatar/views/advertisor/allrewards.dart';
import 'package:avatar/views/advertisor/widget/reusable_tabbar.dart';
import 'package:flutter/material.dart';

class AdvertisorTabbarContainer extends StatelessWidget {
  const AdvertisorTabbarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Points'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ReusableTabbar(
        tabTitles: const [
          'Points',
          'All Rewards',
          'Rewards Claimed',

          'Points History',
          'Transactinal Details',
        ],
        tabContents: const [
          Points(),
          Allrewards(),

          Claimrewards(),
          PointsHistory(),
          TransactionDetailsScreen(),
        ],
      ),
    );
  }
}
