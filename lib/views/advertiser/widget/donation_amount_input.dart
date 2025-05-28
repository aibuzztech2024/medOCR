import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Reusable donation amount input section
class DonationAmountInput extends StatelessWidget {
  final RxDouble donationAmount;
  final TextEditingController amountController;
  final String title;
  final String hintText;
  final String minAmountText;
  final String feeText;

  const DonationAmountInput({
    Key? key,
    required this.donationAmount,
    required this.amountController,
    this.title = 'Donation Amount',
    this.hintText = 'Enter Amount for Donation',
    this.minAmountText = 'Min. ₹100',
    this.feeText = 'Platform Fee 2%',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          '$minAmountText\n$feeText',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF718096),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),

        // Amount input field
        TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
          ),
          style: const TextStyle(fontSize: 16, color: Color(0xFF2D3748)),
        ),
      ],
    );
  }
}
