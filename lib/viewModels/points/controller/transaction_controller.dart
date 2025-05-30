import 'package:avatar/models/points/transaction_model.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  var transaction = Rxn<TransactionModel>();

  @override
  void onInit() {
    super.onInit();
    loadTransaction();
  }

  // TODO: Replace this mock data with real API call
  void loadTransaction() {
    transaction.value = TransactionModel(
      status: 'Ongoing',
      fileType: 'Upload',
      rewardPoints: 5000,
      dateTime: DateTime.parse('2025-03-20T10:30:00'),
      imagePath: 'assets/images/transaction.png',
    );
  }
}
