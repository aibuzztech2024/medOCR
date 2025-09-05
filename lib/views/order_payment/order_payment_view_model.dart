import 'package:avatar/views/order_payment/widgets/other_options_component.dart';
import 'package:avatar/views/order_payment/widgets/payment_summary.dart';
import 'package:avatar/views/order_payment/widgets/upi_payment_component.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OrderPaymentController extends GetxController {
  // Cash on delivery selection state (reactive)
  final _isCashOnDeliverySelected = true.obs;
  bool get isCashOnDeliverySelected => _isCashOnDeliverySelected.value;

  // Payment summary data
  List<PaymentItem> get paymentItems => [
    PaymentItem(label: 'Estimated Medicine Cost', value: '\$100'),
    PaymentItem(label: 'GST on medicine(12%)', value: '\$10'),
  ];

  PaymentItem get totalItem =>
      PaymentItem(label: 'Total estimated cost + GST', value: '\$110');

  // UPI payment options with bound methods
  List<UpiPaymentOption> get upiPaymentOptions => [
    UpiPaymentOption(
      label: 'Paytm UPI',
      iconAsset: 'assets/icons/paytm.svg',
      onTap: _handlePaytmPayment,
    ),
    UpiPaymentOption(
      label: 'Google Pay',
      iconAsset: 'assets/icons/gpay.svg',
      onTap: _handleGooglePayPayment,
    ),
    UpiPaymentOption(
      label: 'PhonePe',
      iconAsset: 'assets/icons/phonepe.svg',
      onTap: _handlePhonePePayment,
    ),
  ];

  // Other payment options with bound methods
  List<OptionItem> get otherOptions => [
    OptionItem(
      title: 'Credit/Debit Card',
      iconAsset: 'assets/icons/credit_card.svg',
      onTap: _handleCardPayment,
    ),
    OptionItem(
      title: 'Wallets',
      iconAsset: 'assets/icons/wallet.svg',
      onTap: _handleWalletPayment,
    ),
    OptionItem(
      title: 'Net Banking',
      iconAsset: 'assets/icons/net_banking.svg',
      onTap: _handleNetBankingPayment,
    ),
  ];

  // UPI payment method handlers
  void _handlePaytmPayment() {
    Get.snackbar('Payment', 'Paytm UPI selected');
  }

  void _handleGooglePayPayment() {
    Get.snackbar('Payment', 'Google Pay selected');
  }

  void _handlePhonePePayment() {
    Get.snackbar('Payment', 'PhonePe selected');
  }

  // Other payment method handlers
  void _handleCardPayment() {
    Get.snackbar('Payment', 'Credit/Debit Card selected');
  }

  void _handleWalletPayment() {
    Get.snackbar('Payment', 'Wallet payment selected');
  }

  void _handleNetBankingPayment() {
    Get.snackbar('Payment', 'Net Banking selected');
  }

  // Toggle cash on delivery selection
  void handleCashOnDeliveryTap() {
    _isCashOnDeliverySelected.toggle();
  }

  // Handle add new UPI option
  void handleAddNewUpiTap() {
    Get.snackbar('UPI', 'Add new UPI option');
  }
}
