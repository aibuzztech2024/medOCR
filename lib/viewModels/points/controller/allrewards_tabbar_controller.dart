import 'package:get/get.dart';

/// Controller to manage the active tab index in Allrewards tabbar.
class AllRewardsTabbarController extends GetxController {
  /// Observable active tab index
  RxInt activeIndex = 0.obs;

  /// Change the active tab index
  void changeTab(int index) {
    activeIndex.value = index;
  }
}
