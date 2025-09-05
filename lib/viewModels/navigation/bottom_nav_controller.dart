import 'package:get/get.dart';
import 'package:avatar/models/navigation/bottom_nav_item_model.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;
  var navItems = <BottomNavItemModel>[].obs;

  void setNavItems(List<BottomNavItemModel> items) {
    navItems.value = items;
  }

  void changeTab(int index) {
    if (index >= 0 && index < navItems.length) {
      currentIndex.value = index;
    }
  }
}
