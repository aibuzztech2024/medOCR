import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../viewModels/transaction/transaction_controller.dart';

class TransactionHistory extends StatelessWidget {
  // Initialize TransactionController using GetX dependency injection
  final TransactionController controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        const SizedBox(height: 40),

        // Header row with sortable "Date & Time" and static "Type"
        Container(
          width: Get.width * 0.9,
          color: const Color(0xFFF79E1B), // Custom orange color
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Sortable Date & Time column header
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

              // Static Type column header
              const Text(
                'Type',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Table and Pagination container with fixed height
        SizedBox(
          height: Get.height * 0.5,
          child: Column(
            children: [
              // Scrollable DataTable showing paginated transactions
              Expanded(
                child: SingleChildScrollView(
                  child: DataTable(
                    dataRowMaxHeight: 50,
                    dividerThickness: 0,
                    columns: const [
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('')),
                    ],

                    // Build table rows from paginatedTransactions list
                    rows: controller.paginatedTransactions.map((txn) {
                      return DataRow(cells: [
                        DataCell(Text(DateFormat('dd MMM yyyy, hh:mm a').format(txn.dateTime))),
                        DataCell(Text(txn.title)),
                      ]);
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 12), // Space between table and pagination

              // Pagination controls with Previous, page numbers, and Next buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Previous button, disabled on first page
                  Obx(() => TextButton(
                    onPressed: controller.currentPage.value == 1 ? null : controller.previousPage,
                    child: const Text('Previous', style: TextStyle(color: Colors.black54)),
                  )),

                  // Dynamic page number buttons (max 3 visible)
                  Obx(() {
                    List<Widget> pages = [];
                    int current = controller.currentPage.value;
                    int total = controller.totalPages;

                    // Calculate start and end page indexes for pagination display
                    int start = (current - 1).clamp(1, total - 2);
                    int end = (start + 2).clamp(1, total);

                    // Adjust start if range is smaller than 3
                    if (end - start < 2) {
                      start = (end - 2).clamp(1, total - 2);
                    }

                    // Create page buttons
                    for (int i = start; i <= end; i++) {
                      bool selected = i == current;
                      pages.add(
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: ElevatedButton(
                            onPressed: () => controller.goToPage(i),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selected ? const Color(0xFFF79E1B) : Colors.grey.shade300,
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

                  // Next button, disabled on last page
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
