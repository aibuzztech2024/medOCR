import 'package:avatar/models/advertiser/points_view_model.dart';
import 'package:avatar/views/advertisor/widget/badge_timeline.dart';
import 'package:avatar/views/advertisor/widget/how_to_earn_section.dart';
import 'package:avatar/views/advertisor/widget/invite_friends_card.dart';
import 'package:avatar/views/advertisor/widget/points_overview_card.dart';
import 'package:flutter/material.dart';

class Points extends StatelessWidget {
  final PointsViewModel? viewModel;

  const Points({
    super.key,
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final vm = viewModel ?? PointsViewModel(
      totalPoints: 400,
      referralCode: 'rb4yn7g',
      onInvitePressed: () {
        // default callback or no-op
      },
    );

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (vm.showInviteSection)
              InviteFriendsCard(
                referralCode: vm.referralCode,
                onInvitePressed: vm.onInvitePressed,
              ),
            PointsOverviewCard(
              totalPoints: vm.totalPoints,
              pointsBreakdown: vm.pointsBreakdown,
              showChart: vm.showChart,
            ),
            if (vm.showHowToEarnSection)
              const HowToEarnSection(),
            if (vm.showBadgeTimeline)
              BadgeTimeline(badgeLevels: vm.badgeLevels),
          ],
        ),
      ),
    );
  }
}
