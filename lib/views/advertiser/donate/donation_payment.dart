import 'package:avatar/views/advertiser/donate/donation_payment_controller.dart';
import 'package:avatar/views/advertiser/widget/amount_breakdown_card.dart';
import 'package:avatar/views/advertiser/widget/donate_payment_card.dart';
import 'package:avatar/views/advertiser/widget/donation_amount_input.dart';
import 'package:avatar/views/advertiser/widget/payment_option_card.dart';
import 'package:avatar/views/advertiser/widget/custom_button.dart'; // Add this import
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import the reusable components

/// Refactored donation payment screen with reusable components
class DonationPaymentScreen extends StatelessWidget {
  const DonationPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sampleDonation = DonationCardModel1(
      imageUrl:
          'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      title: 'Bharat Seva Mandal',
      subtitle: 'Healthcare Organization',
      distance: '2.5 km',
      category: 'Healthcare',
      description:
          'Complete health assessment including blood work, cardiac evaluation, and nutritionist consultation',
      websiteUrl: 'https://example.com',
    );

    final controller = Get.put(DonationPaymentController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DonationCard(donation: sampleDonation),

            // Donation Amount Section - Using reusable component
            DonationAmountInput(
              donationAmount: controller.ngoAmount,
              amountController: controller.amountController,
            ),
            const SizedBox(height: 24),

            // Payment Method Selection
            _buildPaymentMethodSection(controller),
            const SizedBox(height: 24),

            // Amount Breakdown - Using reusable component
            Obx(
              () => AmountBreakdownCard(
                items: [
                  BreakdownItem(
                    label: 'Amount to NGO',
                    amount: '₹${controller.amountToNGO.toStringAsFixed(2)}',
                  ),
                  BreakdownItem(
                    label: 'Platform Fee (2%)',
                    amount: '₹${controller.platformFee.toStringAsFixed(2)}',
                  ),
                  BreakdownItem(
                    label: 'GST on Platform Fee (18%)',
                    amount: '₹${controller.gstAmount.toStringAsFixed(2)}',
                  ),
                ],
                totalItem: BreakdownItem(
                  label: 'Total',
                  amount: '₹${controller.totalAmount.toStringAsFixed(0)}',
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Row(
              children: [
                // Cancel button
                Expanded(
                  child: CustomButton(
                    text: 'Cancel',
                    onPressed: controller.cancelDonation,
                    isOutlined: true,
                    borderColor: Colors.black,
                    textColor: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    borderRadius: 8,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
                const SizedBox(width: 12),
                // Pay button
                Expanded(
                  child: Obx(
                    () =>
                        controller.isProcessing.value
                            ? Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF6B6B),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            )
                            : CustomButton(
                              text: 'Pay',
                              onPressed: controller.processPayment,
                              backgroundColor: const Color(0xFFFF6B6B),
                              textColor: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              borderRadius: 8,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.03),
          ],
        ),
      ),
    );
  }

  /// Build app bar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        'Donation',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build payment method selection section
  Widget _buildPaymentMethodSection(DonationPaymentController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Account or card for donation',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 16),

        // UPI Section
        const Text(
          'UPI',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4A5568),
          ),
        ),
        const SizedBox(height: 12),

        // UPI Option - Using reusable component
        Obx(
          () => UPIPaymentOption(
            method: 'UPI',
            isSelected: controller.selectedPaymentMethod.value == 'UPI',
            onTap: () => controller.selectPaymentMethod('UPI'),
          ),
        ),

        const SizedBox(height: 20),

        // More ways to pay section
        const Text(
          'MORE WAYS TO PAY',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF718096),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),

        // Other payment options - Using reusable components
        Obx(
          () => PaymentOptionsContainer(
            children: [
              PaymentOptionCard(
                method: 'Net Banking',
                isSelected:
                    controller.selectedPaymentMethod.value == 'Net Banking',
                onTap: () => controller.selectPaymentMethod('Net Banking'),
                showDivider: true,
              ),
              PaymentOptionCard(
                method: 'Cash on delivery/Pay on delivery',
                isSelected:
                    controller.selectedPaymentMethod.value ==
                    'Cash on delivery/Pay on delivery',
                onTap:
                    () => controller.selectPaymentMethod(
                      'Cash on delivery/Pay on delivery',
                    ),
                showDivider: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
