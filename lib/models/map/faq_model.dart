// lib/models/faq/faq_model.dart

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

class FAQCategory {
  final String title;
  final List<FAQItem> items;

  FAQCategory({required this.title, required this.items});
}
