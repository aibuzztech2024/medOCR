import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:avatar/views/points/allrewards.dart';
import 'package:avatar/views/points/claimrewards.dart';
import 'package:avatar/views/points/points.dart';
import 'package:avatar/views/points/points_history.dart';

class PointsTabbarController extends GetxController {
  // Observable list of tab titles (if you want them dynamic)
  final RxList<String> tabTitles =
      <String>[
        'Points',
        'All Rewards',
        'Rewards Claimed',
        'Points History',
      ].obs;

  // Tabs' content widgets
  final List<Widget> tabContents = [
    const Points(),
    const Allrewards(),
    Claimrewards(),
    PointsHistory(),
  ];

  // TODO: Add reactive logic to update tab titles or contents if needed
}
