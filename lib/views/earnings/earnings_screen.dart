import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/earnings/controllers/earnings_controller.dart';
import 'package:avatar/views/earnings/widgets/account_dropdown_widget.dart';
import 'package:avatar/views/earnings/widgets/badge_card_widget.dart';
import 'package:avatar/views/earnings/widgets/stat_card_widget.dart';
import 'package:avatar/views/earnings/widgets/withdraw_button_widget.dart';
import 'package:avatar/views/purchase/widgets/transaction_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Earnings screen that displays user's earnings info, transactions,
/// and allows linking UPI accounts and initiating withdrawals.
class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EarningsController>(
      init: EarningsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          body: Obx(() {
            final earningsData = controller.earningsData;

            // TODO: Handle loading and error states properly (loading spinner, error message, retry button).
            if (earningsData == null) {
              return Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  // Top section: Title and Withdraw button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.heading(
                        'Earnings',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      Obx(
                        () => WithdrawButtonWidget(
                          onPressed:
                              controller
                                  .withdraw, // TODO: Backend API integration for withdrawal
                          isLoading: controller.isLoading,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  AppText.heading(
                    'Manage Finances – Payments, Earnings & Revenue Insights',
                    fontWeight: FontWeight.w400,
                  ),

                  const SizedBox(height: 15),

                  // Tab section (Earnings / Transaction History)
                  Row(
                    children: [
                      Expanded(child: _buildTab('Earnings', 0, controller)),
                      Expanded(
                        child: _buildTab('Transaction History', 1, controller),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Stats cards: Total Purchases & Reward Points
                  if (controller.selectedTabIndex == 0) ...[
                    // === Earnings Tab Content ===
                    Row(
                      children: [
                        Expanded(
                          child: StatCardWidget(
                            title: 'Total Purchases',
                            value:
                                earningsData.totalPurchases
                                    .toString(), // TODO: Connect to backend total purchases data
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatCardWidget(
                            title: 'Reward Points',
                            value:
                                earningsData.rewardPoints
                                    .toString(), // TODO: Connect to backend reward points data
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // Linked UPI Account Section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8.5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.heading(
                            'Linked UPI Account',
                            fontWeight: FontWeight.w600,
                          ),

                          // Add account icon
                          GestureDetector(
                            onTap: () {
                              controller
                                  .addNewAccount(); // TODO: Navigate to add new UPI account screen or dialog
                            },
                            child: const Icon(
                              Icons.add,
                              color: LightThemeColors.pharmacyColor,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Dropdown to show and select UPI accounts
                    AccountDropdownWidget(
                      selectedAccount: earningsData.linkedAccount,
                      onAccountSelected:
                          controller
                              .selectAccount, // TODO: Update backend with selected account if needed
                    ),

                    const SizedBox(height: 15),

                    // How to earn points section
                    BadgeCardWidget(
                      badges:
                          earningsData
                              .badges, // TODO: Fetch badges info from backend
                    ),
                  ] else ...[
                    // === Transaction History Tab Content ===
                    TransactionHistory(),
                  ],
                ],
              ),
            );
          }),
        );
      },
    );
  }

  /// Builds a single tab widget with underline if selected.
  Widget _buildTab(String title, int index, EarningsController controller) {
    return Obx(() {
      final isSelected = index == controller.selectedTabIndex;
      return GestureDetector(
        onTap:
            () => controller.setSelectedTab(
              index,
            ), // TODO: Handle tab change logic
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color:
                    isSelected
                        ? LightThemeColors.pharmacyColor
                        : Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            if (isSelected)
              Container(
                height: 2,
                width: double.infinity,
                color: LightThemeColors.pharmacyColor,
              ),
          ],
        ),
      );
    });
  }
}
