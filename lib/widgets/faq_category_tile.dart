// lib/widgets/faq_category_tile.dart
import 'package:flutter/material.dart';
import '../core/widgets/app_text.dart';
import '../models/map/faq_model.dart';
import 'faq_item_widget.dart';

class FAQCategoryTile extends StatelessWidget {
  final FAQCategory category;

  const FAQCategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: Border(),
      title: AppText.heading(category.title),
      initiallyExpanded: false,
      children: [
        Column(
          children:
              category.items.map((item) => FAQItemWidget(item: item)).toList(),
        ),
      ],
    );
  }
}
