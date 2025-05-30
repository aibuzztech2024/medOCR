import 'package:get/get.dart';
import 'package:avatar/models/points/claimed_reward_model.dart';
import 'package:avatar/core/constants/image_paths.dart';

class PointsHistoryViewModel extends GetxController {
  // RxList for reactive updates
  final RxList<ClaimedReward> pointsHistory = <ClaimedReward>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPointsHistory();
  }

  void fetchPointsHistory() {
    // TODO: Replace this with real API call
    pointsHistory.value = [
      ClaimedReward(
        imageUrl: ImagePaths.goodiestars,
        title: 'Upload',
        subtitle: 'Purchase',
        claimedOn: '20 Mar 2025 10:30 AM',
        expiredOn: '',
        points: 3.00,
      ),
      ClaimedReward(
        imageUrl: ImagePaths.goodiestars,
        title: 'Invite',
        subtitle: 'Referred a friend',
        claimedOn: '18 Mar 2025 02:00 PM',
        expiredOn: '',
        points: 5.00,
      ),
    ];
  }
}
