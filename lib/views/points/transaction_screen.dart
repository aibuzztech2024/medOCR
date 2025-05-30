import 'package:avatar/viewModels/points/controller/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/views/points/widget/statuschip.dart';
import 'package:avatar/views/points/widget/transaction_row.dart';
import 'package:avatar/views/points/widget/transactionalimagecard_widget.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({super.key});

  // Initialize GetX Controller
  final TransactionController controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Transaction Details'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          final transaction = controller.transaction.value;

          if (transaction == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TransactionImageCard(
                istransaction: true,
                imagePath: transaction.imagePath,
              ),
              const SizedBox(height: 16),
              TransactionRow(
                label: 'Status',
                value: StatusChip(status: transaction.status),
              ),
              TransactionRow(
                label: 'File Type',
                value: Text(transaction.fileType),
              ),
              TransactionRow(
                label: 'Reward Points',
                value: Text(transaction.rewardPoints.toString()),
              ),
              TransactionRow(
                label: 'Date & Time',
                value: Text(
                  '${transaction.dateTime.day} ${_monthName(transaction.dateTime.month)} ${transaction.dateTime.year}, '
                  '${_formatTime(transaction.dateTime)}',
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
