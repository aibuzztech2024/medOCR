import 'package:get/get.dart';
import '../../models/hospital/order_history_model.dart';

class OrderHistoryController extends GetxController {
  var orderHistoryList = <OrderHistoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrderHistory();
  }

  void fetchOrderHistory() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulated API
    orderHistoryList.value = [
      OrderHistoryModel(
        imageUrls: [
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
        ],
        orderDate: DateTime.parse("2025-06-10T15:43:00"),
        price: 2341,
      ),
    ];
  }
}
