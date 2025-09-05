import 'package:flutter/material.dart';

/// Reusable amount breakdown card widget
class AmountBreakdownCard extends StatelessWidget {
  final List<BreakdownItem> items;
  final BreakdownItem totalItem;
  final EdgeInsets padding;

  const AmountBreakdownCard({
    Key? key,
    required this.items,
    required this.totalItem,
    this.padding = const EdgeInsets.all(16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Regular items
          ...items.map(
            (item) => Column(
              children: [
                BreakdownRow(
                  label: item.label,
                  amount: item.amount,
                  isTotal: false,
                ),
                if (item != items.last) const SizedBox(height: 12),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: const Color(0xFFE2E8F0)),
          const SizedBox(height: 16),
          // Total item
          BreakdownRow(
            label: totalItem.label,
            amount: totalItem.amount,
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

/// Individual breakdown row widget
class BreakdownRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isTotal;

  const BreakdownRow({
    Key? key,
    required this.label,
    required this.amount,
    this.isTotal = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: const Color(0xFF2D3748),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: const Color(0xFF2D3748),
          ),
        ),
      ],
    );
  }
}

/// Data model for breakdown items
class BreakdownItem {
  final String label;
  final String amount;

  const BreakdownItem({required this.label, required this.amount});
}
