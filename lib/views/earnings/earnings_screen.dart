import 'package:avatar/viewModels/earnings/controllers/earnings_controller.dart';
import 'package:avatar/views/earnings/widgets/account_dropdown_widget.dart';
import 'package:avatar/views/earnings/widgets/badge_card_widget.dart';
import 'package:avatar/views/earnings/widgets/stat_card_widget.dart';
import 'package:avatar/views/earnings/widgets/withdraw_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EarningsController>(
      init: EarningsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const SizedBox(),
            title: const Text(
              'Earnings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            actions: [
              Obx(() => WithdrawButtonWidget(
                onPressed: controller.withdraw,
                isLoading: controller.isLoading,
              )),
              const SizedBox(width: 16),
            ],
          ),
          body: Obx(() {
            if (controller.isLoading && controller.earningsData == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.error.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.error,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: controller.refreshData,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final earningsData = controller.earningsData;
            if (earningsData == null) return const SizedBox();

            return RefreshIndicator(
              onRefresh: controller.refreshData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Manage Finances – Payments, Earnings & Revenue Insights',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Tab Bar
                    Row(
                      children: [
                        _buildTab('Earnings', 0, controller),
                        const SizedBox(width: 32),
                        _buildTab('Transaction History', 1, controller),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Stats Cards
                    Row(
                      children: [
                        Expanded(
                          child: StatCardWidget(
                            title: 'Total Purchases',
                            value: earningsData.totalPurchases.toString(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatCardWidget(
                            title: 'Reward Points',
                            value: earningsData.rewardPoints.toString(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Linked UPI Account
                    const Text(
                      'Linked UPI Account',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AccountDropdownWidget(
                      selectedAccount: earningsData.linkedAccount,
                      onAccountSelected: controller.selectAccount,
                      onAddAccount: controller.addNewAccount,
                      accounts: controller.availableAccounts,
                    ),
                    const SizedBox(height: 24),
                    
                    // How to earn points
                    BadgeCardWidget(badges: earningsData.badges),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildTab(String title, int index, EarningsController controller) {
    return Obx(() {
      final isSelected = index == controller.selectedTabIndex;
      return GestureDetector(
        onTap: () => controller.setSelectedTab(index),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? const Color(0xFFFF8C00) : Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            if (isSelected)
              Container(
                height: 2,
                width: 40,
                color: const Color(0xFFFF8C00),
              ),
          ],
        ),
      );
    });
  }
}