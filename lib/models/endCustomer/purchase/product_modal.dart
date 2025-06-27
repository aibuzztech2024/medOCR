/// Model to represent a product or medicine item.
class Product {
  final String imageUrl;
  final String name;
  final String manufacturer;
  final String packaging;
  final String saltComposition;
  final double price;
  final double mrp;
  final String quantity; // e.g., "Strip of 15 Units" or "Bottle of 150 ML"
  final bool prescriptionReceived;
  final bool isRecommendation;

  bool isBookmarked; // Local UI state for favorites/bookmarks

  Product({
    required this.imageUrl,
    required this.name,
    required this.manufacturer,
    required this.packaging,
    required this.saltComposition,
    required this.price,
    required this.mrp,
    required this.quantity,
    required this.prescriptionReceived,
    required this.isRecommendation,
    this.isBookmarked = false,
  });
}
String getDiscountPercent(double mrp, double price) {
  if (mrp == 0 || mrp <= price) return '';
  final discount = ((mrp - price) / mrp) * 100;
  return '${discount.toStringAsFixed(0)}% OFF';
}
