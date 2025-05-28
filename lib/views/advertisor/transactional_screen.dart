import 'package:avatar/views/advertisor/widget/statuschip.dart';
import 'package:avatar/views/advertisor/widget/transactionaldetailedrow_widget.dart';
import 'package:avatar/views/advertisor/widget/transactionalimagecard_widget.dart';
import 'package:flutter/material.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TransactionImageCard(
              imagePath: 'assets/images/avatar_logo.jpg',
            ),
            const SizedBox(height: 16),
            const TransactionDetailRow(
              label: 'File Type',
              value: Text('Upload'),
            ),
            const TransactionDetailRow(
              label: 'Date & Time',
              value: Text('20 Mar 2025, 10:30 AM'),
            ),
            const TransactionDetailRow(
              label: 'Reward Points',
              value: Text('5000'),
            ),
            const TransactionDetailRow(
              label: 'Status',
              value: StatusChip(status: 'Ongoing'),
            ),

            const Divider(height: 32),
            const TransactionDetailRow(
              label: 'Post Reference ID',
              value: Text('AVTR203245'),
            ),
            const TransactionDetailRow(
              label: 'Uploaded By',
              value: Text('@username123'),
            ),
            const TransactionDetailRow(
              label: 'Downloaded On',
              value: Text('23 April 2025, 04:40 PM'),
            ),
            const Spacer(),
            const Center(
              child: Text(
                '*This is a system-generated document.*',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
