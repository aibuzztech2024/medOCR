
import 'package:get/get.dart';

class OrderSummaryController extends GetxController {
  var medicineCost = 0.0.obs;
  var gstPercent = 12.0.obs;
  var earnedPoints = 0.0.obs;
  var previousPointBalance = 0.0.obs;

  // Derived fields

  double get gstAmount => medicineCost.value * gstPercent.value / 100;

  double get totalCost => medicineCost.value + gstAmount;

  double get updatedPointBalance =>
      previousPointBalance.value + earnedPoints.value;


  @override
  void onInit() {
    super.onInit();
    loadPreviousPointBalance();
  }

  // Mock method to load existing balance
  void loadPreviousPointBalance() {
    // e.g. simulate an API call
    previousPointBalance.value = 4352.0;
  }
}
