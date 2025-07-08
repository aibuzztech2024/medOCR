import 'package:avatar/models/register_advisor/post_performance_model.dart';
import 'package:get/get.dart';

class PostPerformanceController extends GetxController {
  // Observable variables
  final _performanceData = PostPerformanceModel(
    totalCoupons: 0,
    totalRedemptions: 0,
    activeCoupons: 0,
    lastUpdated: 'Last 30 days',
  ).obs;

  final _isLoading = false.obs;
  final _error = ''.obs;

  // Getters
  PostPerformanceModel get performanceData => _performanceData.value;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;

  @override
  void onInit() {
    super.onInit();
    fetchPerformanceData();
  }

  // Simulate API call to fetch data
  Future<void> fetchPerformanceData() async {
    try {
      _isLoading.value = true;
      _error.value = '';

      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock data - replace with actual API call
      final mockData = PostPerformanceModel(
        totalCoupons: 25,
        totalRedemptions: 185,
        activeCoupons: 25,
        lastUpdated: 'Last 30 days',
      );

      _performanceData.value = mockData;
    } catch (e) {
      _error.value = 'Failed to load performance data';
    } finally {
      _isLoading.value = false;
    }
  }

  // Method to refresh data
  Future<void> refreshData() async {
    await fetchPerformanceData();
  }

  // Method to update specific values (for demo purposes)
  void updateCoupons(int newCount) {
    _performanceData.update((data) {
      if (data != null) {
        _performanceData.value = PostPerformanceModel(
          totalCoupons: newCount,
          totalRedemptions: data.totalRedemptions,
          activeCoupons: data.activeCoupons,
          lastUpdated: data.lastUpdated,
        );
      }
    });
  }
}