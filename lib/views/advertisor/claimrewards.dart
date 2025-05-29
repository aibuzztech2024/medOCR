import 'package:avatar/core/constants/image_paths.dart';
import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/custum_searchbar.dart';
import 'package:avatar/models/advertiser/claimed_reward_model.dart';
import 'package:avatar/views/advertisor/widget/rewards_claimed.dart';
import 'package:flutter/material.dart';

// this is the claim rewards screen
class Claimrewards extends StatelessWidget {
  const Claimrewards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.scaffoldBackground,

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // search bar
            CustomSearchBar(),
            SizedBox(height: 10),

            // rewards claimed cards used here 
            RewardsClaimed(
              reward: ClaimedReward(
                imageUrl: ImagePaths.goodies,
                title: 'Wellness Forever',
                subtitle: 'Wellness starter kit',
                claimedOn: '20 Mar 2025 10:30 AM',
                expiredOn: '20 Mar 2025 10:30 AM',
                points: 3.00,
              ),
            ),
            RewardsClaimed(
              reward: ClaimedReward(
                imageUrl: ImagePaths.goodies,
                title: 'Wellness Forever',
                subtitle: 'Wellness starter kit',
                claimedOn: '20 Mar 2025 10:30 AM',
                expiredOn: '20 Mar 2025 10:30 AM',
                points: 3.00,
              ),
            ),
            RewardsClaimed(
              reward: ClaimedReward(
                imageUrl: ImagePaths.goodies,
                title: 'Wellness Forever',
                subtitle: 'Wellness starter kit',
                claimedOn: '20 Mar 2025 10:30 AM',
                expiredOn: '20 Mar 2025 10:30 AM',
                points: 3.00,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
