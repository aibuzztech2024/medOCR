import 'dart:ffi';

import 'package:flutter/material.dart';

// This is the custom image card usedn in transaction screens
class TransactionImageCard extends StatelessWidget {
  final String imagePath;
  final bool istransaction;

  const TransactionImageCard({
    super.key,
    this.istransaction = false,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imagePath,
        height: istransaction ? 220 : 180,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
