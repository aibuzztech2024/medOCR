import 'package:avatar/models/points/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionViewModel extends ChangeNotifier {
  TransactionModel? _transaction;

  TransactionModel? get transaction => _transaction;

  // TODO: Replace this mock method with API call to fetch transaction data
  void loadTransaction() {
    // Mock data for now
    _transaction = TransactionModel(
      status: 'Ongoing',
      fileType: 'Upload',
      rewardPoints: 5000,
      dateTime: DateTime.parse('2025-03-20T10:30:00'),
      imagePath:
          'assets/images/transaction.png', // Replace with actual path or network URL
    );
    notifyListeners();
  }
}
