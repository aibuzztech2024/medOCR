import 'package:get/get.dart';
import 'package:avatar/models/points/claimed_reward_model.dart';
import 'package:avatar/core/constants/image_paths.dart';

class ClaimRewardsViewModel extends GetxController {
  // Using RxList to make rewards reactive
  final RxList<ClaimedReward> rewards = <ClaimedReward>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchClaimedRewards();
  }

  void fetchClaimedRewards() {
    // TODO: Replace with real API call when ready
    rewards.value = [
      ClaimedReward(
        imageUrl: ImagePaths.goodies,
        title: 'Wellness Forever',
        subtitle: 'Wellness starter kit',
        claimedOn: '20 Mar 2025 10:30 AM',
        expiredOn: '30 Mar 2025 10:30 AM',
        points: 3.00,
      ),
      ClaimedReward(
        imageUrl: ImagePaths.goodies,
        title: 'Health Pharmacy',
        subtitle: 'Vitamin Pack',
        claimedOn: '18 Mar 2025 9:00 AM',
        expiredOn: '28 Mar 2025 9:00 AM',
        points: 2.50,
      ),
    ];
  }
}
