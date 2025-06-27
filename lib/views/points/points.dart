import 'package:avatar/core/constants/image_paths.dart';
import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/models/points/points_view_model.dart';
import 'package:avatar/views/points/widget/badge_timeline.dart';
import 'package:avatar/views/points/widget/how_to_earn_section.dart';
import 'package:avatar/views/points/widget/invite_friends_card.dart';
import 'package:avatar/views/points/widget/points_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

// this is the Points screen
class Points extends StatelessWidget {
  final PointsViewModel? viewModel;

  const Points({super.key, this.viewModel});

  @override
  Widget build(BuildContext context) {
    final vm =
        viewModel ??
        // points model
        PointsViewModel(
          totalPoints: 400,
          referralCode: 'rb4yn7g',
          onInvitePressed: () {
            // default callback or no-op
          },
        );

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (vm.showInviteSection)
              //invite card widget
              InviteFriendsCard(
                referralCode: vm.referralCode,
                title: 'Invite Friends to Earn Points',
                subtitle: 'invite & earn',
                imagePath: ImagePaths.bestfriends,
                color: LightThemeColors.pharmacyColor,
                colors: LightThemeColors.pharmacyColor15,
              ),

            //points overview card widget
            PointsOverviewCard(
              totalPoints: vm.totalPoints,
              pointsBreakdown: vm.pointsBreakdown,
              showChart: vm.showChart,
              color: LightThemeColors.pharmacyColor,
            ),

            // hero earn widget
            if (vm.showHowToEarnSection) const HowToEarnSection(),

            // badge timeline widget
            if (vm.showBadgeTimeline)
              BadgeTimeline(badgeLevels: vm.badgeLevels),
          ],
        ),
      ),
    );
  }
}
