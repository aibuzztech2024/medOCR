import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

// this row is used in transaction screen 
class TransactionRow extends StatelessWidget {
  final String label;
  final Widget value;

  const TransactionRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: AppText.body(label, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(flex: 5, child: value),
        ],
      ),
    );
  }
}
