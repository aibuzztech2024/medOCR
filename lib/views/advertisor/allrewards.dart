import 'package:avatar/core/constants/image_paths.dart';
import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/models/advertiser/reward_model.dart';
import 'package:avatar/views/advertisor/widget/allrewards_tabbar.dart';
import 'package:avatar/views/advertisor/widget/reward_card.widget.dart';
import 'package:flutter/material.dart';

// this is the All rewards screen
class Allrewards extends StatelessWidget {
  const Allrewards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.scaffoldBackground,
      body: AllrewardsTabbar(
        tabTitles: const ['Featured Rewards\nFor You', 'Popular\nCoupons'],
        backgroundColor: LightThemeColors.inputFill,
        tabContents: [
          // Featured Rewards Content
          _buildFeaturedRewardsContent(),
          // Popular Coupons Content
          _buildPopularCouponsContent(),
        ],
      ),
    );
  }

  // featured rewards content
  Widget _buildFeaturedRewardsContent() {
    return ListView(
      children: [
        RewardCardWidget(
          reward: Reward(
            imageUrl: ImagePaths.featuredrewards,
            headerText: '25 % Off Premium Supplements',
            subheadingText:
                'Complete health assessment including blood work, cardiac evaluation, and nutritionist consultation',
            lowerHeadingText: 'Redeemed',
            currentPoints: 80,
            totalPoints: 100,
            couponCode: '#123ghjs',
          ),
        ),
        RewardCardWidget(
          reward: Reward(
            imageUrl: ImagePaths.featuredrewards,
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

  // popular Coupons content
  Widget _buildPopularCouponsContent() {
    return ListView(
      children: [
        RewardCardWidget(
          isPopularcoupon: true,
          reward: Reward(
            imageUrl: '',
            headerText: '25 % Off Premium Supplements',
            subheadingText:
                'Complete health assessment including blood work, cardiac evaluation, and nutritionist consultation',
            lowerHeadingText: 'Redeemed',
            currentPoints: 80,
            totalPoints: 100,
            couponCode: '#gym789',
          ),
        ),
        RewardCardWidget(
          isPopularcoupon: true,
          reward: Reward(
            imageUrl: '',
            headerText: '25 % Off Premium Supplements',
            subheadingText:
                'Complete health assessment including blood work, cardiac evaluation, and nutritionist consultation',
            lowerHeadingText: 'Redeemed',
            currentPoints: 60,
            totalPoints: 100,
            couponCode: '#nutr123',
          ),
        ),
      ],
    );
  }
}
