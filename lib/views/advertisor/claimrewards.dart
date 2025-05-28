import 'package:avatar/core/widgets/custum_searchbar.dart';
import 'package:avatar/models/advertiser/claimed_reward_model.dart';
import 'package:avatar/views/advertisor/widget/rewards_claimed.dart';
import 'package:flutter/material.dart';

class Claimrewards extends StatelessWidget {
  const Claimrewards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomSearchBar(),
            RewardsClaimed(
              reward: ClaimedReward(
                imageUrl: 'assets/images/login_register_image.png',
                title: 'Wellness Forever',
                subtitle: 'Wellness starter kit',
                claimedOn: '20 Mar 2025 10:30 AM',
                expiredOn: '20 Mar 2025 10:30 AM',
                points: 3.00,
              ),
            ),
            RewardsClaimed(
              reward: ClaimedReward(
                imageUrl: 'assets/images/login_register_image.png',
                title: 'Wellness Forever',
                subtitle: 'Wellness starter kit',
                claimedOn: '20 Mar 2025 10:30 AM',
                expiredOn: '20 Mar 2025 10:30 AM',
                points: 3.00,
              ),
            ),
            RewardsClaimed(
              reward: ClaimedReward(
                imageUrl: 'assets/images/login_register_image.png',
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
