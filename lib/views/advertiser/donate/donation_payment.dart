import 'package:avatar/views/advertiser/donate/donation_payment_controller.dart';
import 'package:avatar/views/advertiser/donate/donation_detailed_read_more_controller.dart';
import 'package:avatar/views/advertiser/widget/amount_breakdown_card.dart';
import 'package:avatar/views/advertiser/widget/custom_button.dart';
import 'package:avatar/views/advertiser/widget/donate_payment_card.dart';
import 'package:avatar/views/advertiser/widget/donation_amount_input.dart';
import 'package:avatar/views/advertiser/widget/payment_option_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Main donation payment screen with data model integration
class DonationPaymentScreen extends StatelessWidget {
  const DonationPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(DonationPaymentController());

    // Get donation data from navigation arguments
    final DonationCardModel1? passedDonation =
        Get.arguments as DonationCardModel1?;

    // Use passed data or fallback to sample data
    final donation = passedDonation ?? _createFallbackDonation();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(donation.title), // Dynamic app bar title
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display organization details using passed data
            DonationPaymentCard(donation: donation),

            // Donation amount input section
            DonationAmountInput(
              donationAmount: controller.ngoAmount,
              amountController: controller.amountController,
            ),
            const SizedBox(height: 24),

            // Payment method selection section
            _buildPaymentMethodSection(controller),
            const SizedBox(height: 24),

            // Amount breakdown display
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

            // Action buttons row
            Row(
              children: [
                // Cancel donation button
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
                // Process payment button
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

  /// Build dynamic app bar with organization name
  AppBar _buildAppBar(String organizationTitle) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Donate to ${_truncateTitle(organizationTitle)}', // Dynamic title
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Truncate long organization titles for app bar
  String _truncateTitle(String title) {
    if (title.length > 20) {
      return '${title.substring(0, 17)}...';
    }
    return title;
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

        // UPI section header
        const Text(
          'UPI',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4A5568),
          ),
        ),
        const SizedBox(height: 12),

        // UPI payment option
        Obx(
          () => UPIPaymentOption(
            method: 'UPI',
            isSelected: controller.selectedPaymentMethod.value == 'UPI',
            onTap: () => controller.selectPaymentMethod('UPI'),
          ),
        ),

        const SizedBox(height: 20),

        // Alternative payment methods section
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

        // Other payment options container
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

  /// Create fallback donation data if no arguments passed
  DonationCardModel1 _createFallbackDonation() {
    return DonationCardModel1(
      imageUrl:
          'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      title: 'Bharat Seva Mandal',
      subtitle: 'Healthcare Organization',
      distance: '2.5 km',
      category: 'Healthcare',
      description:
          'Complete sux health assessment including blood work, cardiac evaluation, and nutritionist consultation',
      websiteUrl: 'https://example.com',
    );
  }
}
