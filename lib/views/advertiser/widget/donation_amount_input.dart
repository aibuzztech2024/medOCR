import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Reusable donation amount input section
class DonationAmountInput extends StatelessWidget {
  final RxDouble donationAmount;
  final TextEditingController amountController;
  final String title;
  final String hintText;
  final String feeText;
  final double initialAmount;
  final double minAmount; // Add minimum amount parameter

  const DonationAmountInput({
    Key? key,
    required this.donationAmount,
    required this.amountController,
    this.title = 'Donation Amount',
    this.hintText = 'Enter Amount for Donation',
    this.feeText = 'Platform Fee 2%',
    this.initialAmount = 0.0,
    this.minAmount = 100.0, // Default minimum amount
  }) : super(key: key);

  // Validator function
  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount';
    }

    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Please enter a valid amount';
    }

    if (amount < minAmount) {
      return 'Minimum amount is ₹${minAmount.toStringAsFixed(0)}';
    }

    return null; // No error
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the amount with the organization's amount
    if (initialAmount > 0) {
      donationAmount.value = initialAmount;
      amountController.text = initialAmount.toStringAsFixed(0);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: Get.height * 0.02),
        // Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 16),
        // Amount display
        Obx(
          () => Text(
            '₹${donationAmount.value.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Min amount and fee info
        Text(
          'Min. ₹${donationAmount.value.toStringAsFixed(0)}\n$feeText',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF718096),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        // Amount input field with validation
        TextFormField(
          controller: amountController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: _validateAmount,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            // Update donation amount as user types
            final amount = double.tryParse(value);
            if (amount != null && amount >= minAmount) {
              donationAmount.value = amount;
            }
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 16),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
          style: const TextStyle(fontSize: 16, color: Color(0xFF2D3748)),
        ),
      ],
    );
  }
}
