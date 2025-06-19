import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller for managing donation payment screen state and business logic
class DonationPaymentController extends GetxController {
  // Observable variables for reactive UI updates
  final RxDouble ngoAmount = 100.0.obs; // Amount that goes to NGO
  final RxString selectedPaymentMethod = 'UPI'.obs;
  final RxBool isProcessing = false.obs;

  // Text editing controller for amount input
  final TextEditingController amountController = TextEditingController();

  // Constants for calculation
  static const double minAmount = 100.0;
  static const double platformFeePercentage = 0.02; // 2%
  static const double gstPercentage = 0.18; // 18%

  // Payment method options
  final List<PaymentMethod> paymentMethods = [
    PaymentMethod('UPI', 'assets/icons/upi_icon.png', true),
    PaymentMethod('Net Banking', 'assets/icons/bank_icon.png', false),
    PaymentMethod(
      'Cash on delivery/Pay on delivery',
      'assets/icons/cod_icon.png',
      false,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize amount controller with default NGO amount
    amountController.text = ngoAmount.value.toStringAsFixed(0);
    // Listen to text changes and update reactive variable
    amountController.addListener(_onAmountChanged);
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }

  /// Handle amount text field changes
  /// Updates the NGO amount based on user input
  void _onAmountChanged() {
    final text = amountController.text;
    if (text.isNotEmpty) {
      final amount = double.tryParse(text) ?? minAmount;
      ngoAmount.value = amount;
    }
  }

  /// Update NGO donation amount
  /// @param amount - The amount that will go to the NGO
  void updateAmount(double amount) {
    if (amount >= minAmount) {
      ngoAmount.value = amount;
      amountController.text = amount.toStringAsFixed(0);
    }
  }

  /// Select payment method
  /// @param method - The selected payment method name
  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  /// Calculate platform fee (2% of NGO amount)
  /// Platform fee is charged on the amount going to NGO
  double get platformFee => ngoAmount.value * platformFeePercentage;

  /// Calculate GST (18% of platform fee)
  /// GST is applied on the platform fee
  double get gstAmount => platformFee * gstPercentage;

  /// Get amount going to NGO (user input amount)
  /// This is the base amount that user wants to donate to NGO
  double get amountToNGO => ngoAmount.value;

  /// Calculate total amount user needs to pay
  /// Total = NGO Amount + Platform Fee + GST
  /// Example: If NGO amount is ₹100
  /// Platform Fee = ₹100 * 2% = ₹2
  /// GST = ₹2 * 18% = ₹0.36
  /// Total = ₹100 + ₹2 + ₹0.36 = ₹102.36
  double get totalAmount => ngoAmount.value + platformFee + gstAmount;

  /// Get breakdown of charges for display
  Map<String, double> get chargeBreakdown => {
    'NGO Amount': amountToNGO,
    'Platform Fee (2%)': platformFee,
    'GST on Platform Fee (18%)': gstAmount,
    'Total Amount': totalAmount,
  };

  /// Process payment with updated total calculation
  Future<void> processPayment() async {
    if (ngoAmount.value < minAmount) {
      Get.snackbar(
        'Invalid Amount',
        'Minimum donation amount is ₹${minAmount.toStringAsFixed(0)}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
      return;
    }

    try {
      isProcessing.value = true;

      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));

      // Show success message with total amount paid
      Get.snackbar(
        'Payment Successful',
        'Thank you for your donation!\nNGO receives: ₹${amountToNGO.toStringAsFixed(2)}\nTotal paid: ₹${totalAmount.toStringAsFixed(2)}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade800,
        duration: const Duration(seconds: 4),
      );

      // Navigate back or to success screen
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Payment Failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
    } finally {
      isProcessing.value = false;
    }
  }

  /// Cancel donation process
  void cancelDonation() {
    Get.back();
  }

  /// Helper method to format currency for display
  String formatCurrency(double amount) {
    return '₹${amount.toStringAsFixed(2)}';
  }

  /// Validate minimum amount
  bool get isValidAmount => ngoAmount.value >= minAmount;

  /// Get formatted breakdown text for UI display
  String get breakdownText {
    return '''
NGO Amount: ${formatCurrency(amountToNGO)}
Platform Fee (2%): ${formatCurrency(platformFee)}
GST (18%): ${formatCurrency(gstAmount)}
────────────────────
Total: ${formatCurrency(totalAmount)}''';
  }
}

/// Model class for payment methods
class PaymentMethod {
  final String name;
  final String iconPath;
  final bool isDefault;

  PaymentMethod(this.name, this.iconPath, this.isDefault);
}
