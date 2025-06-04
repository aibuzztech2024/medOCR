import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/custum_searchbar.dart';
import 'package:avatar/viewModels/points/points_history_viewmodel.dart';
import 'package:avatar/views/points/widget/rewards_claimed.dart';

class PointsHistory extends StatelessWidget {
  PointsHistory({super.key});

  // Initialize controller using Get.put()
  final PointsHistoryViewModel viewModel = Get.put(PointsHistoryViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const CustomSearchBar(),
            const SizedBox(height: 10),

            Expanded(
              child: Obx(() {
                final pointsHistory = viewModel.pointsHistory;
                if (pointsHistory.isEmpty) {
                  return const Center(
                    child: Text('No points history available.'),
                  );
                }
                return ListView.builder(
                  itemCount: pointsHistory.length,
                  itemBuilder: (context, index) {
                    return RewardsClaimed(
                      reward: pointsHistory[index],
                      isPointsHistory: true,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
