import 'package:get/get.dart';

// all rewards tabbar controller
class AllrewardsTabbarContoller extends GetxController {
  RxInt activeIndex = 0.obs;

  void changeTab(int index) {
    activeIndex.value = index;
  }
}
