import 'package:get/get.dart';

// tabbar controller
class TabbarController extends GetxController {
  var activeIndex = 0.obs;

  void setActiveIndex(int index) {
    activeIndex.value = index;
  }
}
