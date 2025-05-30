import 'package:avatar/viewModels/points/controller/transaction_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/views/points/widget/statuschip.dart';
import 'package:avatar/views/points/widget/transactionaldetailedrow_widget.dart';
import 'package:avatar/views/points/widget/transactionalimagecard_widget.dart';

class TransactionDetailsScreen extends StatelessWidget {
  TransactionDetailsScreen({super.key});

  final TransactionDetailsController controller = Get.put(
    TransactionDetailsController(),
  );

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
          final details = controller.transactionDetails.value;

          if (details == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TransactionImageCard(imagePath: details.imagePath),
              const SizedBox(height: 16),
              TransactionDetailRow(
                label: 'File Type',
                value: Text(details.fileType),
              ),
              TransactionDetailRow(
                label: 'Date & Time',
                value: Text(
                  '${details.dateTime.day} ${_monthName(details.dateTime.month)} ${details.dateTime.year}, '
                  '${_formatTime(details.dateTime)}',
                ),
              ),
              TransactionDetailRow(
                label: 'Reward Points',
                value: Text(details.rewardPoints.toString()),
              ),
              TransactionDetailRow(
                label: 'Status',
                value: StatusChip(status: details.status),
              ),
              const Divider(height: 32),
              TransactionDetailRow(
                label: 'Post Reference ID',
                value: Text(details.postReferenceId),
              ),
              TransactionDetailRow(
                label: 'Uploaded By',
                value: Text(details.uploadedBy),
              ),
              TransactionDetailRow(
                label: 'Downloaded On',
                value: Text(
                  '${details.downloadedOn.day} ${_monthName(details.downloadedOn.month)} ${details.downloadedOn.year}, '
                  '${_formatTime(details.downloadedOn)}',
                ),
              ),
              const Spacer(),
              const Center(
                child: Text(
                  '*This is a system-generated document.*',
                  style: TextStyle(fontSize: 12),
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
