class OrderHistoryModel {
  final List<String> imageUrls;
  final DateTime orderDate;
  final double price;

  OrderHistoryModel({
    required this.imageUrls,
    required this.orderDate,
    required this.price,
  });
}
