class Product {
  final String imageUrl;
  final String name;
  final String type;           // e.g. "Tablet" or "Syrup"
  final String dosage;         // e.g. "500 MG" or "150 ML"
  final double price;          // e.g. 220.0
  final double mrp;            // e.g. 245.0
  final String quantity;       // e.g. "60 Tablets"
  final bool prescriptionReceived;
  final String brand;          // e.g. "Cipla"
  final String manufacturer;   // e.g. "ABC Pharmaceuticals"
  final String category;       // e.g. "Pain Relief"
  final bool inCartMode;

  bool isBookmarked;           // local UI state

  Product({
    required this.imageUrl,
    required this.name,
    required this.type,
    required this.dosage,
    required this.price,
    required this.mrp,
    required this.quantity,
    required this.prescriptionReceived,
    required this.brand,
    required this.manufacturer,
    required this.category,
    required this.inCartMode,
    this.isBookmarked = false,
  });
}
