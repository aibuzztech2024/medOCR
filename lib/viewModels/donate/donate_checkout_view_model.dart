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
  RxBool isLoading = false.obs;

  final TextEditingController amountController = TextEditingController();

  // Track user input as string
  RxString inputText = ''.obs;

  // FocusNode for custom amount input field
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
      enteredAmount.value >= 100 && // Ensure minimum ₹100
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

  // Async donation submission that returns a Future
  Future<void> submitDonation() async {
    if (!isFormValid || donation.value == null) {
      throw Exception('Form is invalid or donation data missing');
    }

    final campaign = donation.value!;

    // Simulate network call or async work with delay
    await Future.delayed(const Duration(seconds: 2));

    // Actual submission logic here
    print('Donation Submitted');
    print('Campaign: ${campaign.title}');
    print('Amount: ₹${enteredAmount.value}');
    print('Payment Method: ${selectedPaymentMethod.value == 1 ? "UPI" : "Card"}');
    print('PAN: ${panNumber.value}');
    print('Document Path: ${panDocument.value?.path ?? "None"}');

    // You can throw an error here if submission fails, to test catchError
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
