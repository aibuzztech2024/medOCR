import 'package:get/get.dart';
import '../../models/transaction/transaction_model.dart';

class TransactionController extends GetxController {
  // Controls sorting order (ascending/descending)
  var isAscending = true.obs;

  // List of all transactions (observable)
  final RxList<Transaction> transactions = [
    Transaction(dateTime: DateTime.parse("2025-03-02 08:45:00"), title: "Login"),
    Transaction(dateTime: DateTime.parse("2025-03-05 10:10:00"), title: "Purchase"),
    Transaction(dateTime: DateTime.parse("2025-03-08 14:22:00"), title: "Map"),
    Transaction(dateTime: DateTime.parse("2025-03-08 14:22:00"), title: "Map"),
    Transaction(dateTime: DateTime.parse("2025-03-08 14:22:00"), title: "Map"),
    Transaction(dateTime: DateTime.parse("2025-03-11 11:30:00"), title: "Upload"),

  ].obs;

  // Sort the transactions list by date, toggling ascending/descending
  void sortByDate() {
    transactions.sort((a, b) => isAscending.value
        ? a.dateTime.compareTo(b.dateTime)
        : b.dateTime.compareTo(a.dateTime));
    isAscending.toggle();
  }
}
