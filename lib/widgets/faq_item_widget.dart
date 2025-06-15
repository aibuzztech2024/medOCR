// lib/widgets/faq_item_widget.dart
import 'package:flutter/material.dart';
import '../core/widgets/app_text.dart';
import '../models/map/faq_model.dart';
import 'package:avatar/core/widgets/height_box.dart';

class FAQItemWidget extends StatelessWidget {
  final FAQItem item;

  const FAQItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.heading('Q: ${item.question}', fontSize: 16),
          const HeightBox(8),
          AppText.body(
            'A: ${item.answer}',
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ],
      ),
    );
  }
}
