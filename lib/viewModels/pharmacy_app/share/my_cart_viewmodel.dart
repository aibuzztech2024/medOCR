import 'package:avatar/models/pharmacy_app/purchase/productModal.dart';
import 'package:get/get.dart';

class MyCartViewModel extends GetxController {
  // Observable list for cart products
  final RxList<Product> _cartProducts = <Product>[].obs;

  // Observable values for cost calculation
  final RxDouble _medicineCost = 0.0.obs;
  final RxInt _creditPoints = 0.obs;

  // Observable flags
  final RxBool _isLoading = false.obs;
  final RxBool _prescriptionUploaded = false.obs;
  final RxBool _balancePrescriptionUploaded = false.obs;

  // Getters
  List<Product> get cartProducts => _cartProducts;
  double get medicineCost => _medicineCost.value;
  int get creditPoints => _creditPoints.value;
  bool get isLoading => _isLoading.value;
  bool get prescriptionUploaded => _prescriptionUploaded.value;
  bool get balancePrescriptionUploaded => _balancePrescriptionUploaded.value;

  @override
  void onInit() {
    super.onInit();
    _initializeCartData();
  }

  // Initialize cart with dummy data
  void _initializeCartData() {
    _cartProducts.addAll([
      Product(
        imageUrl: 'assets/images/tablet.png',
        name: 'Crocin Pain Relief Tablet -1',
        type: 'Tablet',
        dosage: '500 MG',
        price: 220,
        mrp: 245,
        quantity: '60 Tablets',
        brand: 'Cipla',
        manufacturer: 'ABC Pharmaceuticals',
        category: 'Pain Relief',
        prescriptionReceived: true,
        inCartMode: true,
        isBookmarked: false,
      ),
      Product(
        imageUrl: 'assets/images/tablet.png',
        name: 'Paracetamol Tablet',
        type: 'Tablet',
        dosage: '650 MG',
        price: 150,
        mrp: 170,
        quantity: '30 Tablets',
        brand: 'GSK',
        manufacturer: 'GlaxoSmithKline',
        category: 'Pain Relief',
        prescriptionReceived: false,
        inCartMode: true,
        isBookmarked: false,
      ),
      Product(
        imageUrl: 'assets/images/tablet.png',
        name: 'Ibuprofen Capsule',
        type: 'Capsule',
        dosage: '400 MG',
        price: 180,
        mrp: 200,
        quantity: '20 Capsules',
        brand: 'Pfizer',
        manufacturer: 'Pfizer Pharmaceuticals',
        category: 'Anti-inflammatory',
        prescriptionReceived: true,
        inCartMode: true,
        isBookmarked: false,
      ),
      Product(
        imageUrl: 'assets/images/tablet.png',
        name: 'Aspirin Tablet',
        type: 'Tablet',
        dosage: '75 MG',
        price: 120,
        mrp: 140,
        quantity: '100 Tablets',
        brand: 'Bayer',
        manufacturer: 'Bayer Healthcare',
        category: 'Cardiovascular',
        prescriptionReceived: true,
        inCartMode: true,
        isBookmarked: false,
      ),
    ]);

    _medicineCost.value = 9898;
    _creditPoints.value = 98997;
  }

  // Cart operations - dummy implementations
  void addToCart(Product product) {
    // TODO: Implement add to cart logic
    _cartProducts.add(product);
    _calculateTotalCost();
  }

  void removeFromCart(Product product) {
    // TODO: Implement remove from cart logic
    _cartProducts.remove(product);
    _calculateTotalCost();
  }

  void updateProductQuantity(Product product, int quantity) {
    // TODO: Implement quantity update logic
    _calculateTotalCost();
  }

  void toggleBookmark(Product product) {
    // TODO: Implement bookmark toggle logic
    int index = _cartProducts.indexOf(product);
    if (index != -1) {
      _cartProducts[index].isBookmarked = !_cartProducts[index].isBookmarked;
      _cartProducts.refresh();
    }
  }

  // Prescription operations - dummy implementations
  void uploadPrescription() {
    // TODO: Implement prescription upload logic
    _prescriptionUploaded.value = true;
  }

  void uploadBalancePrescription() {
    // TODO: Implement balance prescription upload logic
    _balancePrescriptionUploaded.value = true;
  }

  void proceedAnyway() {
    // TODO: Implement proceed anyway logic
    print('Proceeding without prescription');
  }

  // Address operations - dummy implementations
  void selectDeliveryAddress() {
    // TODO: Implement address selection logic
    print('Address selection clicked');
  }

  void addNewAddress() {
    // TODO: Implement add new address logic
    print('Add new address clicked');
  }

  // Payment operations - dummy implementations
  void selectPaymentMethod() {
    // TODO: Implement payment method selection logic
    print('Payment method selection clicked');
  }

  void addNewPaymentMethod() {
    // TODO: Implement add new payment method logic
    print('Add new payment method clicked');
  }

  // Order operations - dummy implementations
  void viewPointsHistory() {
    // TODO: Implement points history view logic
    print('View points history clicked');
  }

  void viewOrderSummary() {
    // TODO: Implement order summary view logic
    print('View order summary clicked');
  }

  void placeOrder() {
    // TODO: Implement place order logic
    _isLoading.value = true;

    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      _isLoading.value = false;
      print('Order placed successfully');
    });
  }

  // Helper methods
  void _calculateTotalCost() {
    // TODO: Implement cost calculation logic
    double total = 0;
    for (var product in _cartProducts) {
      total += product.price;
    }
    _medicineCost.value = total;
  }

  void clearCart() {
    // TODO: Implement clear cart logic
    _cartProducts.clear();
    _calculateTotalCost();
  }

  int get totalItems => _cartProducts.length;

  double get totalSavings {
    // TODO: Implement savings calculation
    double savings = 0;
    for (var product in _cartProducts) {
      savings += (product.mrp - product.price);
    }
    return savings;
  }
}
