import 'package:flutter/material.dart';

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
          Expanded(flex: 3, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
          const Text(":", style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
          Expanded(flex: 5, child: value),
        ],
      ),
    );
  }
}
