import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/donate/donate_checkout_model.dart';

class DonateCheckoutViewModel extends GetxController {
  Rx<DonateCheckoutModel?> donation = Rx<DonateCheckoutModel?>(null);
  RxInt enteredAmount = 100.obs;
  RxInt selectedPaymentMethod = 0.obs;
  RxString panNumber = ''.obs;
  Rx<File?> panDocument = Rx<File?>(null);

  final TextEditingController amountController = TextEditingController();

  // New: Track user input as string
  RxString inputText = ''.obs;

  // New: FocusNode for custom amount input field
  final FocusNode amountFocusNode = FocusNode();

  // Initialize donation details
  void initializeDonation(DonateCheckoutModel model) {
    donation.value = model;
    enteredAmount.value = 100;
    amountController.text = '100';
    inputText.value = '100';
    selectedPaymentMethod.value = 0;
    panNumber.value = '';
    panDocument.value = null;
  }

  // Validate form completeness
  bool get isFormValid =>
      enteredAmount.value >= 0 &&
          selectedPaymentMethod.value != 0 &&
          panNumber.value.trim().isNotEmpty &&
          panDocument.value != null;

  // Select payment method
  void selectPaymentMethod(int method) {
    selectedPaymentMethod.value = method;
  }

  // Update entered amount
  void updateAmount(int value) {
    enteredAmount.value = value;
    inputText.value = value > 0 ? value.toString() : '';
  }

  // Update PAN number
  void updatePan(String value) {
    panNumber.value = value;
  }

  // Update PAN document
  void updatePanDocument(File file) {
    panDocument.value = file;
  }

  // Handle form submission
  void submitDonation() {
    if (!isFormValid || donation.value == null) return;

    final campaign = donation.value!;
    print('Donation Submitted');
    print('Campaign: ${campaign.title}');
    print('Amount: ₹${enteredAmount.value}');
    print('Payment Method: ${selectedPaymentMethod.value == 1 ? "UPI" : "Card"}');
    print('PAN: ${panNumber.value}');
    print('Document Path: ${panDocument.value?.path ?? "None"}');
  }

  @override
  void onInit() {
    super.onInit();

    // Sync enteredAmount with inputText and controller
    ever<int>(enteredAmount, (value) {
      final displayText = value > 0 ? value.toString() : '';
      inputText.value = displayText;

      if (amountController.text != displayText) {
        amountController.value = TextEditingValue(
          text: displayText,
          selection: TextSelection.collapsed(offset: displayText.length),
        );
      }
    });
  }

  @override
  void onClose() {
    amountController.dispose();
    amountFocusNode.dispose(); // Dispose the focus node
    super.onClose();
  }
}
