import 'package:get/get.dart';
import '../transaction_details_model.dart';

class TransactionDetailsController extends GetxController {
  var transactionDetails = Rxn<TransactionDetailsModel>();

  @override
  void onInit() {
    super.onInit();
    loadTransactionDetails();
  }

  // TODO: Replace mock data with real API call
  void loadTransactionDetails() {
    transactionDetails.value = TransactionDetailsModel(
      fileType: 'Upload',
      dateTime: DateTime.parse('2025-03-20T10:30:00'),
      rewardPoints: 5000,
      status: 'Ongoing',
      postReferenceId: 'AVTR203245',
      uploadedBy: '@username123',
      downloadedOn: DateTime.parse('2025-04-23T16:40:00'),
      imagePath: 'assets/images/transaction.png',
    );
  }
}
