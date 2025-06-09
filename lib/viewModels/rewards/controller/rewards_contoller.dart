import 'package:avatar/models/rewards/rewards_model.dart';
import 'package:get/get.dart';

class FeatureRewardsController extends GetxController {
  final RxList<RewardModel> rewards = <RewardModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadRewards();
  }

  void loadRewards() {
    isLoading.value = true;

    // Simulating API call
    Future.delayed(const Duration(milliseconds: 500), () {
      rewards.value = [
        RewardModel(
          id: '1',
          title: '25% Off Premium Skincare',
          couponCode: '#123GHJ',
          image: 'assets/images/feature_rewards.png',
          backgroundColor: '#F4E6E1',
          discount: '25%',
        ),
        RewardModel(
          id: '2',
          title: '30% Off Beauty Products',
          couponCode: '#456ABC',
          image: 'assets/images/feature_rewards.png',
          backgroundColor: '#E8F4F8',
          discount: '30%',
        ),
        RewardModel(
          id: '3',
          title: '20% Off Wellness Items',
          couponCode: '#789XYZ',
          image: 'assets/images/feature_rewards.png',
          backgroundColor: '#F0F4E6',
          discount: '20%',
        ),
        RewardModel(
          id: '4',
          title: '15% Off Spa Services',
          couponCode: '#012DEF',
          image: 'assets/images/feature_rewards.png',
          backgroundColor: '#FFF2E6',
          discount: '15%',
        ),
      ];
      isLoading.value = false;
    });
  }

  void onRewardTap(RewardModel reward) {
    Get.snackbar(
      'Coupon Selected',
      'Coupon ${reward.couponCode} copied to clipboard!',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void copyToClipboard(String couponCode) {
    // Implement clipboard functionality
    Get.snackbar(
      'Copied!',
      'Coupon code $couponCode copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }
}
