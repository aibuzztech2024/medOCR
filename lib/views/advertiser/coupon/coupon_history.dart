import 'package:avatar/views/advertiser/coupon/widgets/coupon_code.dart';
import 'package:avatar/viewModels/advertiser/coupon/coupon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponHistory extends StatelessWidget {
  const CouponHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final CouponController controller = Get.put(CouponController());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onChanged: controller.searchCoupons,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  hintText: "Search by coupon code, title or category",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Status Filter (Optional - you can add this later)
            // _buildStatusFilter(controller),

            // Coupons List
            Obx(() {
              if (controller.filteredCoupons.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      'No coupons found',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                );
              }

              return Column(
                children:
                    controller.filteredCoupons.map((coupon) {
                      return CouponCodeComponent(
                        coupon: coupon,
                        onTap: () => controller.onCouponTap(coupon),
                        onCopy: () => controller.copyCouponCode(coupon),
                      );
                    }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }

  // Optional: Add status filter widget
  Widget _buildStatusFilter(CouponController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Obx(() {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                controller.availableStatuses.map((status) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(status),
                      selected: controller.searchQuery.value.isEmpty,
                      onSelected: (selected) {
                        if (selected) {
                          controller.filterByStatus(status);
                        }
                      },
                    ),
                  );
                }).toList(),
          ),
        );
      }),
    );
  }
}
