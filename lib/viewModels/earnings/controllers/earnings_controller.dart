import 'package:avatar/models/earnings/badge_model.dart';
import 'package:avatar/models/earnings/earnings_model.dart';
import 'package:get/get.dart';

class EarningsController extends GetxController {
  // Observable variables
  final Rx<EarningsModel?> _earningsData = Rx<EarningsModel?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;
  final RxInt _selectedTabIndex = 0.obs;

  // Getters
  EarningsModel? get earningsData => _earningsData.value;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;
  int get selectedTabIndex => _selectedTabIndex.value;

  // Available accounts for dropdown
  final RxList<String> availableAccounts = <String>[
    'Monikasingh@okicici',
    'john.doe@example.com',
    'jane.smith@bank.com'
  ].obs;

  @override
  void onInit() {
    super.onInit();
    loadEarningsData();
  }

  // Tab management
  void setSelectedTab(int index) {
    _selectedTabIndex.value = index;
  }

  // Load earnings data (simulate API call)
  Future<void> loadEarningsData() async {
    _isLoading.value = true;
    _error.value = '';

    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      // Mock data - replace with actual API call
      _earningsData.value = EarningsModel(
        totalPurchases: 1500,
        rewardPoints: 4500,
        linkedAccount: 'Monikasingh@okicici',
        badges: [
          BadgeModel(
            name: 'Silver Badge',
            description: '+ Priority delivery access, early access to campaigns',
            pointsRange: '999 points',
            color: 'orange',
          ),
          BadgeModel(
            name: 'Gold Badge',
            description: '+ 1 free health trend report/month',
            pointsRange: '1000 to 2499 points',
            color: 'orange',
          ),
          BadgeModel(
            name: 'Diamond Badge',
            description: '+ Lab test discounts, donation credits, exclusive offers',
            pointsRange: '+150 points per refill',
            color: 'orange',
          ),
        ],
      );
    } catch (e) {
      _error.value = 'Failed to load earnings data: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  // Withdraw action
  Future<void> withdraw() async {
    if (earningsData?.rewardPoints == 0) {
      Get.snackbar(
        'Error',
        'No reward points available to withdraw',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    
    _isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1000));
      
      Get.snackbar(
        'Success',
        'Withdrawal request submitted for ${earningsData?.rewardPoints} points',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.primaryColor,
        colorText: Get.theme.colorScheme.onPrimary,
      );
      
      // You can update the points after successful withdrawal
      // updateRewardPoints(0);
      
    } catch (e) {
      _error.value = 'Withdrawal failed: $e';
      Get.snackbar(
        'Error',
        'Withdrawal failed. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  // Account selection
  void selectAccount(String account) {
    if (_earningsData.value != null) {
      _earningsData.value = _earningsData.value!.copyWith(
        linkedAccount: account,
      );
    }
  }

  // Add new account
  void addNewAccount() {
    // Navigate to add account screen or show dialog
    Get.snackbar(
      'Info',
      'Add new account functionality',
      snackPosition: SnackPosition.TOP,
    );
  }

  // Refresh data
  Future<void> refreshData() async {
    await loadEarningsData();
  }

  // Update reward points (for API integration)
  void updateRewardPoints(int newPoints) {
    if (_earningsData.value != null) {
      _earningsData.value = _earningsData.value!.copyWith(
        rewardPoints: newPoints,
      );
    }
  }

  // Update total purchases (for API integration)
  void updateTotalPurchases(int newPurchases) {
    if (_earningsData.value != null) {
      _earningsData.value = _earningsData.value!.copyWith(
        totalPurchases: newPurchases,
      );
    }
  }
}
