import 'package:get/get.dart';

import '../../../models/endCustomer/purchase/product_modal.dart';

class searchTabController extends GetxController {
  // ──────────────── Observable Lists ────────────────
  /// All dummy products (hard-coded)

  final List<Product> allProducts = <Product>[
    Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Tablet -1',
      price: 220,
      mrp: 245,
      quantity: '60 Tablets',
      manufacturer: 'ABC Pharmaceuticals',
      prescriptionReceived: true,
      isBookmarked: false,
      packaging: 'Bottle',
      saltComposition: 'Paracetamol (650mg), Caffeine (50mg)',
      isRecommendation: true,
    ),
    Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Tablet -2',
      price: 220,
      mrp: 245,
      quantity: '60 Tablets',
      manufacturer: 'ABC Pharmaceuticals',
      prescriptionReceived: false,
      isBookmarked: true,
      packaging: 'Bottle',
      saltComposition: 'Paracetamol (650mg), Caffeine (50mg)',
      isRecommendation: false,
    ),
    Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Tablet -1',

      price: 220,
      mrp: 245,
      quantity: '60 Tablets',
      manufacturer: 'ABC Pharmaceuticals',
      prescriptionReceived: false,
      isBookmarked: false,
      packaging: 'Bottle',
      saltComposition: 'Paracetamol (650mg), Caffeine (50mg)',
      isRecommendation: true,
    ),
    Product(
      imageUrl: 'assets/images/tablet.png',
      name: 'Crocin Pain Relief Tablet -1',

      price: 220,
      mrp: 245,
      quantity: '60 Tablets',
      manufacturer: 'ABC Pharmaceuticals',
      prescriptionReceived: false,
      isBookmarked: false,
      packaging: 'Bottle',
      saltComposition: 'Paracetamol (650mg), Caffeine (50mg)',
      isRecommendation: true,
    ),
  ];

  /// ──────────────── Filter / Search Inputs ────────────────
  var searchText = ''.obs;
  var selectedBrand = ''.obs;
  var selectedManu = ''.obs;
  var selectedCategory = ''.obs;

  var hasSearched = false.obs;
  var sortByBookmark = false.obs;

  /// The filtered subset that the UI will show
  var products = <Product>[].obs;

  /// ──────────────── Pagination State ────────────────
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

  /// ──────────────── Dropdown Options ────────────────
  final List<String> brands = ['Cipla', 'Sun Pharma', 'Alkem'];
  final List<String> manufacturers = ['ABC Pharmaceuticals', 'XYZ Meds', 'Bharat Bio'];
  final List<String> categories = ['Pain Relief', 'Antibiotics', 'Vitamins'];

  /// ──────────────── Clear Results Helper ────────────────
  // Call this whenever any filter changes, so the UI goes back to showing the Search button.
  void clearResults() {
    products.clear();
    currentPage.value = 1;
    hasSearched.value = false;
  }

  /// ──────────────── Filter / Search Logic ────────────────
  void search() {
    final txt = searchText.value.trim().toLowerCase();
    final brandFilter = selectedBrand.value;
    final manuFilter = selectedManu.value;
    final catFilter = selectedCategory.value;

    // Apply all combinations: if a filter is empty, ignore it
    final List<Product> temp =
        allProducts.where((p) {
          final matchesName = txt.isEmpty ? true : p.name.toLowerCase().contains(txt);

          final matchesBrand = brandFilter.isEmpty ? true : p.manufacturer == manuFilter;

          final matchesManu = manuFilter.isEmpty ? true : p.manufacturer == manuFilter;

          final matchesCat = catFilter.isEmpty ? true : p.manufacturer == manuFilter;

          return matchesName && matchesBrand && matchesManu && matchesCat;
        }).toList();

    /// 🔽 Sort by bookmark if enabled
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

  /// ──────────────── Pagination Controls ────────────────
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
