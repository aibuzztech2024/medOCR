import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

// this row s being used in transaction detail screen
class TransactionDetailRow extends StatelessWidget {
  final String label;
  final Widget value;

  const TransactionDetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: AppText.body(label, fontWeight: FontWeight.bold),
          ),
          AppText.body(":", fontWeight: FontWeight.bold),
          const SizedBox(width: 8),
          Expanded(flex: 5, child: value),
        ],
      ),
    );
  }
}
