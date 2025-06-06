import 'package:get/get.dart';

import '../../../models/endCustomer/purchase/product_modal.dart';

// class searchTabController extends GetxController {
//   var searchText = ''.obs;
//   var selectedBrand = ''.obs;
//   var selectedManufacturer = ''.obs;
//   var selectedCategory = ''.obs;
//
//   var products = <Product>[].obs;
//
//   final brands = ['Cipla', 'Sun Pharma', 'Alkem'];
//   final manufacturers = ['ABC Pharmaceuticals', 'XYZ Meds', 'Bharat Bio'];
//   final categories = ['Antibiotics', 'Pain Killers', 'Vitamins'];
//
//   void search() {
//     products.value = dummyData;
//   }
// }

class searchTabController extends GetxController {

  // ──────────────── Observable Lists ────────────────
  // All dummy products (hard-coded)
  final List<Product> allProducts = <Product>[
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
      prescriptionReceived: false,
      inCartMode: false,
      isBookmarked: false,
    ), Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Tablet 2',
      type: 'Tablet',
      dosage: '500 MG',
      price: 220,
      mrp: 245,
      quantity: '60 Tablets',
      brand: 'Cipla',
      manufacturer: 'ABC Pharmaceuticals',
      category: 'Pain Relief',
      prescriptionReceived: false,
      inCartMode: false,
      isBookmarked: true,
    ), Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Tablet 3',
      type: 'Tablet',
      dosage: '500 MG',
      price: 220,
      mrp: 245,
      quantity: '60 Tablets',
      brand: 'Cipla',
      manufacturer: 'ABC Pharmaceuticals',
      category: 'Pain Relief',
      prescriptionReceived: false,
      inCartMode: false,
      isBookmarked: false,
    ), Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Tablet 4',
      type: 'Tablet',
      dosage: '500 MG',
      price: 220,
      mrp: 245,
      quantity: '60 Tablets',
      brand: 'Cipla',
      manufacturer: 'ABC Pharmaceuticals',
      category: 'Pain Relief',
      prescriptionReceived: false,
      inCartMode: false,
      isBookmarked: false,
    ), Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Tablet 5',
      type: 'Tablet',
      dosage: '500 MG',
      price: 220,
      mrp: 245,
      quantity: '60 Tablets',
      brand: 'Cipla',
      manufacturer: 'ABC Pharmaceuticals',
      category: 'Pain Relief',
      prescriptionReceived: false,
      inCartMode: false,
      isBookmarked: true,
    ), Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Tablet',
      type: 'Tablet',
      dosage: '500 MG',
      price: 220,
      mrp: 245,
      quantity: '60 Tablets',
      brand: 'Cipla',
      manufacturer: 'ABC Pharmaceuticals',
      category: 'Pain Relief',
      prescriptionReceived: false,
      inCartMode: false,
      isBookmarked: true,
    ), Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Tablet',
      type: 'Tablet',
      dosage: '500 MG',
      price: 220,
      mrp: 245,
      quantity: '60 Tablets',
      brand: 'Cipla',
      manufacturer: 'ABC Pharmaceuticals',
      category: 'Pain Relief',
      prescriptionReceived: false,
      inCartMode: false,
      isBookmarked: true,
    ), Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Tablet',
      type: 'Tablet',
      dosage: '500 MG',
      price: 220,
      mrp: 245,
      quantity: '60 Tablets',
      brand: 'Cipla',
      manufacturer: 'ABC Pharmaceuticals',
      category: 'Pain Relief',
      prescriptionReceived: false,
      inCartMode: false,
      isBookmarked: true,
    ), Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Tablet',
      type: 'Tablet',
      dosage: '500 MG',
      price: 220,
      mrp: 245,
      quantity: '60 Tablets',
      brand: 'Cipla',
      manufacturer: 'ABC Pharmaceuticals',
      category: 'Pain Relief',
      prescriptionReceived: false,
      inCartMode: false,
      isBookmarked: true,
    ), Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Tablet',
      type: 'Tablet',
      dosage: '500 MG',
      price: 220,
      mrp: 245,
      quantity: '60 Tablets',
      brand: 'Cipla',
      manufacturer: 'ABC Pharmaceuticals',
      category: 'Pain Relief',
      prescriptionReceived: false,
      inCartMode: false,
      isBookmarked: true,
    ), Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Tablet',
      type: 'Tablet',
      dosage: '500 MG',
      price: 220,
      mrp: 245,
      quantity: '60 Tablets',
      brand: 'Cipla',
      manufacturer: 'ABC Pharmaceuticals',
      category: 'Pain Relief',
      prescriptionReceived: false,
      inCartMode: false,
      isBookmarked: true,
    ),
    Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Syrup',
      type: 'Syrup',
      dosage: '150 ML',
      price: 220,
      mrp: 225,
      quantity: '150 ML',
      brand: 'Cipla',
      manufacturer: 'ABC Pharmaceuticals',
      category: 'Pain Relief',
      prescriptionReceived: true,
      inCartMode: false,
    ),
    Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Azithral Antibiotic Tablet',
      type: 'Tablet',
      dosage: '500 MG',
      price: 150,
      mrp: 175,
      quantity: '10 Tablets',
      brand: 'Sun Pharma',
      manufacturer: 'XYZ Meds',
      category: 'Antibiotics',
      prescriptionReceived: false,
      inCartMode: false,
      isBookmarked: true,
    ),
    Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Vitamax Syrup',
      type: 'Syrup',
      dosage: '100 ML',
      price: 180,
      mrp: 200,
      quantity: '100 ML',
      brand: 'Alkem',
      manufacturer: 'Bharat Bio',
      category: 'Vitamins',
      prescriptionReceived: true,
      inCartMode: false,
    ),
    Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Tablet',
      type: 'Tablet',
      dosage: '500 MG',
      price: 220,
      mrp: 245,
      quantity: '60 Tablets',
      brand: 'Cipla',
      manufacturer: 'ABC Pharmaceuticals',
      category: 'Pain Relief',
      prescriptionReceived: false,
      inCartMode: false,
      isBookmarked: true,
    ),
    Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Syrup',
      type: 'Syrup',
      dosage: '150 ML',
      price: 220,
      mrp: 225,
      quantity: '150 ML',
      brand: 'Cipla',
      manufacturer: 'ABC Pharmaceuticals',
      category: 'Pain Relief',
      prescriptionReceived: true,
      inCartMode: false,
    ),
    Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Azithral Antibiotic Tablet',
      type: 'Tablet',
      dosage: '500 MG',
      price: 150,
      mrp: 175,
      quantity: '10 Tablets',
      brand: 'Sun Pharma',
      manufacturer: 'XYZ Meds',
      category: 'Antibiotics',
      prescriptionReceived: false,
      inCartMode: false,
    ),
    Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Vitamax Syrup',
      type: 'Syrup',
      dosage: '100 ML',
      price: 180,
      mrp: 200,
      quantity: '100 ML',
      brand: 'Alkem',
      manufacturer: 'Bharat Bio',
      category: 'Vitamins',
      prescriptionReceived: true,
      inCartMode: false,
      isBookmarked: true,
    ),
    Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Vitamax Syrup',
      type: 'Syrup',
      dosage: '100 ML',
      price: 180,
      mrp: 200,
      quantity: '100 ML',
      brand: 'Alkem',
      manufacturer: 'Bharat Bio',
      category: 'Vitamins',
      prescriptionReceived: true,
      inCartMode: false,
      isBookmarked: true,
    ),
    // …add more dummy products as desired
  ];


  // ──────────────── Filter / Search Inputs ────────────────
  var searchText = ''.obs;
  var selectedBrand = ''.obs;
  var selectedManu = ''.obs;
  var selectedCategory = ''.obs;

  var hasSearched = false.obs;
  var sortByBookmark = false.obs;


  // The filtered subset that the UI will show
  var products = <Product>[].obs;

  // ──────────────── Pagination State ────────────────
  final int itemsPerPage = 5;
  var currentPage = 1.obs;

  int get totalPages {
    if (products.isEmpty) return 1;
    return (products.length / itemsPerPage).ceil();
  }

  List<Product> get pagedProducts {
    if (products.isEmpty) return [];
    int start = (currentPage.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    if (end > products.length) end = products.length;
    return products.sublist(start, end);
  }
  // ──────────────── Dropdown Options ────────────────
  final List<String> brands = ['Cipla', 'Sun Pharma', 'Alkem'];
  final List<String> manufacturers = ['ABC Pharmaceuticals', 'XYZ Meds', 'Bharat Bio'];
  final List<String> categories = ['Pain Relief', 'Antibiotics', 'Vitamins'];


  // ──────────────── Clear Results Helper ────────────────
  // Call this whenever any filter changes, so the UI goes back to showing the Search button.
  void clearResults() {
    products.clear();
    currentPage.value = 1;
    hasSearched.value = false;

  }
  // ──────────────── Filter / Search Logic ────────────────
  void search() {
    final txt = searchText.value.trim().toLowerCase();
    final brandFilter = selectedBrand.value;
    final manuFilter = selectedManu.value;
    final catFilter = selectedCategory.value;

    // Apply all combinations: if a filter is empty, ignore it
    final List<Product> temp =
        allProducts.where((p) {
          final matchesName = txt.isEmpty ? true : p.name.toLowerCase().contains(txt);

          final matchesBrand = brandFilter.isEmpty ? true : p.brand == brandFilter;

          final matchesManu = manuFilter.isEmpty ? true : p.manufacturer == manuFilter;

          final matchesCat = catFilter.isEmpty ? true : p.category == catFilter;

          return matchesName && matchesBrand && matchesManu && matchesCat;
        }).toList();

    // 🔽 Sort by bookmark if enabled
    if (sortByBookmark.value) {
      temp.sort((a, b) {
        if (a.isBookmarked == b.isBookmarked) return 0;
        return b.isBookmarked ? 1 : -1;
      });
    }
    products.value = temp;
    currentPage.value = 1;
    hasSearched.value = true;

  }

  // ──────────────── Pagination Controls ────────────────
  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) {
      currentPage.value = page;
    }
  }

  void nextPage() {
    if (currentPage.value < totalPages) {
      currentPage.value++;
    }
  }

  void prevPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

}
