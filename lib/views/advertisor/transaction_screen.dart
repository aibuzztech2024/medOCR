import 'package:avatar/core/constants/image_paths.dart';
import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/views/advertisor/widget/statuschip.dart';
import 'package:avatar/views/advertisor/widget/transaction_row.dart';
import 'package:avatar/views/advertisor/widget/transactionalimagecard_widget.dart';
import 'package:flutter/material.dart';

// this is the transaction screen
class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // image card widget
            const TransactionImageCard(
              istransaction: true,
              imagePath: ImagePaths.transaction,
            ),
            const SizedBox(height: 16),

            // transcation row widget
            const TransactionRow(
              label: 'Status',
              value: StatusChip(status: 'Ongoing'),
            ),
            const TransactionRow(label: 'File Type', value: Text('Upload')),

            const TransactionRow(label: 'Reward Points', value: Text('5000')),

            const TransactionRow(
              label: 'Date & Time',
              value: Text('20 Mar 2025, 10:30 AM'),
            ),
          ],
        ),
      ),
    );
  }
}
