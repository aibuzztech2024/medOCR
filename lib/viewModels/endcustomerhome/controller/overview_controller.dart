import 'package:avatar/models/endcustomerhome/overview_model.dart';
import 'package:get/get.dart';

/// Controller to manage and update Overview data reactively.
class OverviewController extends GetxController {
  /// List of overview items (bills, purchases, points) as observable.
  var items =
      <OverviewItem>[
        OverviewItem(
          label: 'Bills',
          value: 457,
          subtitle: 'last 36 days',
          iconPath: 'assets/images/bill.png',
        ),
        OverviewItem(
          label: 'Purchases',
          value: 150,
          subtitle: 'last 30 days',
          iconPath: 'assets/images/purchases.png',
        ),
        OverviewItem(
          label: 'Points',
          value: 150,
          subtitle: 'last 365 days',
          iconPath: 'assets/images/wallet_payment.png',
        ),
      ].obs;

  /// Update the value of a specific item based on its label.
  void updateValue(String label, int newValue) {
    final index = items.indexWhere((item) => item.label == label);
    if (index != -1) {
      items[index] = items[index].copyWith(value: newValue);
    }
  }
}
