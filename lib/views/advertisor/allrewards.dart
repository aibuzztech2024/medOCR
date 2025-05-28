import 'package:avatar/models/advertiser/reward_model.dart';
import 'package:avatar/views/advertisor/widget/allrewards_tabbar.dart';
import 'package:avatar/views/advertisor/widget/reward_card.widget.dart';
import 'package:flutter/material.dart';

class Allrewards extends StatelessWidget {
  const Allrewards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AllrewardsTabbar(
        tabTitles: const ['Featured Rewards\nFor You', 'Popular\nCoupons'],
        activeColor: Colors.red[400],
        inactiveColor: Colors.black87,
        backgroundColor: Colors.grey[100],
        tabContents: [
          // Featured Rewards Content
          _buildFeaturedRewardsContent(),
          // Popular Coupons Content
          _buildPopularCouponsContent(),
        ],
      ),
    );
  }

  Widget _buildFeaturedRewardsContent() {
    return ListView(
      children: [
        RewardCardWidget(
          reward: Reward(
            imageUrl: 'assets/images/login_register_image.png',
            headerText: '25 % Off Premium Supplements',
            subheadingText:
                'Complete health assessment including blood work, cardiac evaluation, and nutritionist consultation',
            lowerHeadingText: 'Redeemed',
            currentPoints: 80,
            totalPoints: 100,
            couponCode: '#123ghjs',
          ),
        ),
        const SizedBox(height: 16),
        RewardCardWidget(
          reward: Reward(
            imageUrl: 'assets/images/login_register_image.png',
            headerText: '25 % Off Premium Supplements',
            subheadingText:
                'Complete health assessment including blood work, cardiac evaluation, and nutritionist consultation',
            lowerHeadingText: 'Redeemed',
            currentPoints: 50,
            totalPoints: 100,
            couponCode: '#123ghjs',
          ),
        ),
      ],
    );
  }

  Widget _buildPopularCouponsContent() {
    return ListView(
      children: [
        RewardCardWidget(
          reward: Reward(
            imageUrl: '',
            headerText: '50 % Off Gym Membership',
            subheadingText:
                'Annual gym membership with access to all facilities and personal trainer sessions',
            lowerHeadingText: 'Popular',
            currentPoints: 80,
            totalPoints: 100,
            couponCode: '#gym789',
          ),
        ),
        const SizedBox(height: 16),
        RewardCardWidget(
          reward: Reward(
            imageUrl: '',
            headerText: '40 % Off Nutrition Plan',
            subheadingText:
                'Customized nutrition plan designed by certified nutritionists',
            lowerHeadingText: 'Trending',
            currentPoints: 60,
            totalPoints: 100,
            couponCode: '#nutr123',
          ),
        ),
      ],
    );
  }
}
