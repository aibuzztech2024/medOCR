import 'package:avatar/core/constants/image_paths.dart';
import 'package:avatar/models/points/reward_model.dart';

/// ViewModel providing dummy data and tab titles.
/// TODO: Replace dummy data with real API calls and reactive variables for dynamic data.
class AllRewardsViewModel {
  /// Tab titles for the tabbar
  List<String> get tabTitles => [
    'Featured Rewards\nFor You',
    'Popular\nCoupons',
  ];

  /// Dummy featured rewards data
  List<Reward> get featuredRewards => [
    Reward(
      imageUrl: ImagePaths.featuredrewards,
      headerText: '25% Off Premium Supplements',
      subheadingText:
          'Complete health assessment including blood work, cardiac evaluation, and nutritionist consultation',
      lowerHeadingText: 'Redeemed',
      currentPoints: 80,
      totalPoints: 100,
      couponCode: '#123ghjs',
    ),
    Reward(
      imageUrl: ImagePaths.featuredrewards,
      headerText: 'Buy 1 Get 1 on Proteins',
      subheadingText:
          'Complete health assessment including blood work, cardiac evaluation, and nutritionist consultation',

      lowerHeadingText: 'Redeemed',
      currentPoints: 50,
      totalPoints: 100,
      couponCode: '#456abcd',
    ),
    Reward(
      imageUrl: ImagePaths.featuredrewards,
      headerText: 'Buy 1 Get 1 on Proteins',
      subheadingText:
          'Complete health assessment including blood work, cardiac evaluation, and nutritionist consultation',

      lowerHeadingText: 'Redeemed',
      currentPoints: 50,
      totalPoints: 100,
      couponCode: '#456abcd',
    ),
  ];

  /// Dummy popular coupons data
  List<Reward> get popularCoupons => [
    Reward(
      imageUrl: '',
      headerText: '₹500 Off Nutrition Products',
      subheadingText:
          'Complete health assessment including\nblood work, cardiac evaluation, and\nnutritionist consultation',

      lowerHeadingText: 'Redeemed',
      currentPoints: 60,
      totalPoints: 100,
      couponCode: '#nutr123',
    ),
    Reward(
      imageUrl: '',
      headerText: '15% Off Gym Membership',
      subheadingText:
          'Complete health assessment including\nblood work, cardiac evaluation, and\nnutritionist consultation',

      lowerHeadingText: 'Redeemed',
      currentPoints: 40,
      totalPoints: 100,
      couponCode: '#gym789',
    ),
    Reward(
      imageUrl: '',
      headerText: '15% Off Gym Membership',
      subheadingText:
          'Complete health assessment including\nblood work, cardiac evaluation, and\nnutritionist consultation',

      lowerHeadingText: 'Redeemed',
      currentPoints: 40,
      totalPoints: 100,
      couponCode: '#gym789',
    ),
  ];
}
