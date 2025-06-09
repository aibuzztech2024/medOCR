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
    Transaction(dateTime: DateTime.parse("2025-03-11 11:30:00"), title: "Upload"),
    Transaction(dateTime: DateTime.parse("2025-03-12 12:45:00"), title: "Bill"),
    Transaction(dateTime: DateTime.parse("2025-03-13 17:20:00"), title: "Subscription"),
    Transaction(dateTime: DateTime.parse("2025-03-14 18:00:00"), title: "Login"),
    Transaction(dateTime: DateTime.parse("2025-03-15 19:05:00"), title: "Referral"),
    Transaction(dateTime: DateTime.parse("2025-03-16 13:25:00"), title: "Cashback"),
    Transaction(dateTime: DateTime.parse("2025-03-17 16:40:00"), title: "Profile"),
    Transaction(dateTime: DateTime.parse("2025-03-18 08:55:00"), title: "Purchase"),
    Transaction(dateTime: DateTime.parse("2025-03-19 15:00:00"), title: "Invoice"),
    Transaction(dateTime: DateTime.parse("2025-03-20 10:30:00"), title: "Document"),
    Transaction(dateTime: DateTime.parse("2025-03-21 09:00:00"), title: "Recharge"),
    Transaction(dateTime: DateTime.parse("2025-03-22 11:00:00"), title: "Referral"),
    Transaction(dateTime: DateTime.parse("2025-03-23 14:10:00"), title: "Bank"),
    Transaction(dateTime: DateTime.parse("2025-03-24 12:35:00"), title: "App"),
    Transaction(dateTime: DateTime.parse("2025-03-25 14:15:00"), title: "Map"),
    Transaction(dateTime: DateTime.parse("2025-03-25 16:10:00"), title: "Map"),
    Transaction(dateTime: DateTime.parse("2025-03-26 12:00:00"), title: "Wallet"),
    Transaction(dateTime: DateTime.parse("2025-03-27 13:00:00"), title: "Fund"),
    Transaction(dateTime: DateTime.parse("2025-03-28 14:00:00"), title: "Invoice"),
    Transaction(dateTime: DateTime.parse("2025-03-29 10:00:00"), title: "Document"),
    Transaction(dateTime: DateTime.parse("2025-03-30 10:00:00"), title: "Referral"),
    Transaction(dateTime: DateTime.parse("2025-03-30 10:00:00"), title: "Referral"),
  ].obs;

  // Tracks the current page number for pagination
  var currentPage = 1.obs;

  // Number of items shown per page
  final int itemsPerPage = 6;

  // Total number of pages based on items and page size
  int get totalPages => (transactions.length / itemsPerPage).ceil();

  // Returns the list of transactions to display on the current page
  List<Transaction> get paginatedTransactions {
    final start = (currentPage.value - 1) * itemsPerPage;
    final end = (start + itemsPerPage).clamp(0, transactions.length);
    return transactions.sublist(start, end);
  }

  // Sort the transactions list by date, toggling ascending/descending
  void sortByDate() {
    transactions.sort((a, b) => isAscending.value
        ? a.dateTime.compareTo(b.dateTime)
        : b.dateTime.compareTo(a.dateTime));
    isAscending.toggle();

    // Reset to first page after sorting
    currentPage.value = 1;
  }

  // Change current page to specified page number if valid
  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) {
      currentPage.value = page;
    }
  }

  // Navigate to next page if not on last page
  void nextPage() {
    if (currentPage.value < totalPages) {
      currentPage.value++;
    }
  }

  // Navigate to previous page if not on first page
  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }
}
