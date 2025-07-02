import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Transaction Model
class Transaction {
  final DateTime dateTime;
  final String title;

  Transaction({required this.dateTime, required this.title});
}

/// Controller with Pagination & Sorting
class TransactionController extends GetxController {
  var isAscending = true.obs;

  final RxList<Transaction> transactions = [
    Transaction(dateTime: DateTime.parse("2025-03-02 08:45:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-05 10:10:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-08 14:22:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-11 11:30:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-12 12:45:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-13 17:20:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-14 18:00:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-15 19:05:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-16 13:25:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-17 16:40:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-18 08:55:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-19 15:00:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-20 10:30:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-21 09:00:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-22 11:00:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-23 14:10:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-24 12:35:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-25 14:15:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-25 16:10:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-26 12:00:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-27 13:00:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-28 14:00:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-29 10:00:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-30 10:00:00"), title: "Dr Aisha Rahman"),
    Transaction(dateTime: DateTime.parse("2025-03-30 10:00:00"), title: "Dr Aisha Rahman"),
  ].obs;

  var currentPage = 1.obs;
  final int itemsPerPage = 6;

  int get totalPages => (transactions.length / itemsPerPage).ceil();

  List<Transaction> get paginatedTransactions {
    final start = (currentPage.value - 1) * itemsPerPage;
    final end = (start + itemsPerPage).clamp(0, transactions.length);
    return transactions.sublist(start, end);
  }

  void sortByDate() {
    transactions.sort((a, b) => isAscending.value
        ? a.dateTime.compareTo(b.dateTime)
        : b.dateTime.compareTo(a.dateTime));
    isAscending.toggle();
    currentPage.value = 1;
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) {
      currentPage.value = page;
    }
  }

  void nextPage() {
    if (currentPage.value < totalPages) currentPage.value++;
  }

  void previousPage() {
    if (currentPage.value > 1) currentPage.value--;
  }
}

/// TransactionHistory widget without Scaffold for embedding
class TransactionHistory extends StatelessWidget {
  final TransactionController controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        // Header row
        Container(
          width: Get.width * 0.9,
          color: const Color(0xFF3AAFA9),
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: controller.sortByDate,
                child: Row(
                  children: const [
                    Text(
                      'Date & Time',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    FaIcon(FontAwesomeIcons.sort, color: Colors.white, size: 14),
                  ],
                ),
              ),
              const Text(
                'Doctor',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Table & Pagination container
        SizedBox(
          height: Get.height * 0.5,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: DataTable(
                    dataRowMaxHeight: 50,
                    dividerThickness: 0,
                    columns: const [
                      DataColumn(label: Text('Date & Time')),
                      DataColumn(label: Text('Title')),
                    ],
                    rows: controller.paginatedTransactions.map((txn) {
                      return DataRow(cells: [
                        DataCell(Text(DateFormat('dd MMM yyyy, hh:mm a').format(txn.dateTime))),
                        DataCell(Text(txn.title)),
                      ]);
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Pagination controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => TextButton(
                    onPressed: controller.currentPage.value == 1 ? null : controller.previousPage,
                    child: const Text('Previous', style: TextStyle(color: Colors.black54)),
                  )),

                  Obx(() {
                    List<Widget> pages = [];
                    int current = controller.currentPage.value;
                    int total = controller.totalPages;

                    int start = (current - 1).clamp(1, total - 2);
                    int end = (start + 2).clamp(1, total);

                    if (end - start < 2) {
                      start = (end - 2).clamp(1, total - 2);
                    }

                    for (int i = start; i <= end; i++) {
                      bool selected = i == current;
                      pages.add(
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: ElevatedButton(
                            onPressed: () => controller.goToPage(i),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selected ? const Color(0xFF3AAFA9) : Colors.grey.shade300,
                              foregroundColor: selected ? Colors.white : Colors.black,
                              minimumSize: const Size(35, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(i.toString()),
                          ),
                        ),
                      );
                    }

                    return Row(children: pages);
                  }),

                  Obx(() => TextButton(
                    onPressed: controller.currentPage.value == controller.totalPages ? null : controller.nextPage,
                    child: const Text('Next', style: TextStyle(color: Colors.black54)),
                  )),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
