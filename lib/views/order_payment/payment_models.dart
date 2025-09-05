import 'package:flutter/material.dart';

// models/payment_models.dart
class PaymentItem {
  final String label;
  final String value;

  PaymentItem({required this.label, required this.value});
}

class UpiPaymentOption {
  final String label;
  final String iconAsset;
  final VoidCallback onTap;

  UpiPaymentOption({
    required this.label,
    required this.iconAsset,
    required this.onTap,
  });
}

class OptionItem {
  final String title;
  final String iconAsset;
  final VoidCallback onTap;

  OptionItem({
    required this.title,
    required this.iconAsset,
    required this.onTap,
  });
}
