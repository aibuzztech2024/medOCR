import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/views/advertisor/points.dart';
import 'package:avatar/views/advertisor/claimrewards.dart';
import 'package:avatar/views/advertisor/points_history.dart';
import 'package:avatar/views/advertisor/transactional_details_screen.dart';
import 'package:avatar/views/advertisor/allrewards.dart';
import 'package:avatar/views/advertisor/widget/reusable_tabbar.dart';
import 'package:flutter/material.dart';

// this is the first container thorugh which naviagtion of tabbar works
class AdvertisorTabbarContainer extends StatelessWidget {
  const AdvertisorTabbarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Points'),
        centerTitle: true,
        backgroundColor: LightThemeColors.scaffoldBackground,
      ),
      body: ReusableTabbar(
        tabTitles: const [

          // Give title

          'Points',
          'All Rewards',
          'Rewards Claimed',
          'Points History',
        ],
        tabContents: const [

          // displays screems to navigate
          
          Points(),
          Allrewards(),
          Claimrewards(),
          PointsHistory(),
        ],
      ),
    );
  }
}
