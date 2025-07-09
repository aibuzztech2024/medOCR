import 'package:get/get.dart';
import 'package:avatar/models/coupon/coupon_model.dart';

class CouponController extends GetxController {
  final RxList<CouponModel> coupons = <CouponModel>[].obs;
  final RxList<CouponModel> filteredCoupons = <CouponModel>[].obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoupons();
  }

  void fetchCoupons() {
    // TODO: Replace with actual API call
    coupons.value = [
      CouponModel(
        id: '1',
        code: 'SUMMER2025',
        title: 'SUMMER Mega Offer',
        description: 'Get amazing discounts on summer collection',
        status: 'Active',
        expiryDate: DateTime.parse('2025-03-20'),
        discountPercentage: 25.0,
        maxDiscountAmount: 500.0,
        minOrderAmount: 1000.0,
        category: 'Fashion',
      ),
      CouponModel(
        id: '2',
        code: 'WINTER2025',
        title: 'Winter Collection Sale',
        description: 'Special discounts on winter wear',
        status: 'Active',
        expiryDate: DateTime.parse('2025-02-15'),
        discountPercentage: 30.0,
        maxDiscountAmount: 750.0,
        minOrderAmount: 1500.0,
        category: 'Fashion',
      ),
      CouponModel(
        id: '3',
        code: 'NEWUSER50',
        title: 'New User Welcome',
        description: 'Welcome offer for new users',
        status: 'Used',
        expiryDate: DateTime.parse('2025-01-10'),
        usedDate: DateTime.parse('2025-01-05'),
        discountPercentage: 50.0,
        maxDiscountAmount: 1000.0,
        minOrderAmount: 500.0,
        category: 'General',
      ),
      CouponModel(
        id: '4',
        code: 'FLASH25',
        title: 'Flash Sale',
        description: 'Limited time flash sale offer',
        status: 'Expired',
        expiryDate: DateTime.parse('2024-12-31'),
        discountPercentage: 25.0,
        maxDiscountAmount: 300.0,
        minOrderAmount: 800.0,
        category: 'Electronics',
      ),
      CouponModel(
        id: '5',
        code: 'LOYALTY20',
        title: 'Loyalty Reward',
        description: 'Special discount for loyal customers',
        status: 'Active',
        expiryDate: DateTime.parse('2025-04-30'),
        discountPercentage: 20.0,
        maxDiscountAmount: 400.0,
        minOrderAmount: 1200.0,
        category: 'General',
      ),
    ];

    filteredCoupons.value = coupons;
  }

  void searchCoupons(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredCoupons.value = coupons;
    } else {
      filteredCoupons.value =
          coupons.where((coupon) {
            return coupon.code.toLowerCase().contains(query.toLowerCase()) ||
                coupon.title.toLowerCase().contains(query.toLowerCase()) ||
                (coupon.category != null &&
                    coupon.category!.toLowerCase().contains(
                      query.toLowerCase(),
                    ));
          }).toList();
    }
  }

  void filterByStatus(String status) {
    if (status == 'All') {
      filteredCoupons.value = coupons;
    } else {
      filteredCoupons.value =
          coupons
              .where(
                (coupon) => coupon.status.toLowerCase() == status.toLowerCase(),
              )
              .toList();
    }
  }

  void copyCouponCode(CouponModel coupon) {
    // This method can be used to track copy events
    // You can add analytics or other tracking logic here
    print('Coupon code copied: ${coupon.code}');
  }

  void onCouponTap(CouponModel coupon) {
    // Navigate to coupon details page or show more information
    print('Coupon tapped: ${coupon.id}');
    // TODO: Implement navigation to coupon details
  }

  List<String> get availableStatuses {
    final statuses = coupons.map((coupon) => coupon.status).toSet().toList();
    statuses.insert(0, 'All');
    return statuses;
  }

  int get activeCouponsCount {
    return coupons.where((coupon) => coupon.status == 'Active').length;
  }

  int get expiredCouponsCount {
    return coupons.where((coupon) => coupon.status == 'Expired').length;
  }

  int get usedCouponsCount {
    return coupons.where((coupon) => coupon.status == 'Used').length;
  }
}
