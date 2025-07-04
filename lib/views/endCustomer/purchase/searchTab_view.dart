import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/views/endCustomer/purchase/widgets/dropdownfield.dart';
import 'package:avatar/views/endCustomer/purchase/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../models/endCustomer/purchase/product_modal.dart';
import '../../../viewModels/endCustomer/purchase/search_controller.dart';

/// To DO CHANGE COLOR IN SCREEN

class searchTab_view extends StatelessWidget {
  const searchTab_view();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<searchTabController>();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// search field and bookmark sort
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      isCollapsed: true,

                      hintText: 'Search by medicine name or categories',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(146, 146, 146, 1),
                      ),
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),

                    onTapOutside: (PointerDownEvent) {
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (val) {
                      controller.searchText.value = val;
                      controller.clearResults(); // clear existing results
                    },
                  ),
                ),
              ),
              Obx(
                () => IconButton(
                  icon: Icon(
                    controller.sortByBookmark.value
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: LightThemeColors.pharmacyColor,
                  ),
                  onPressed: () {
                    controller.sortByBookmark.toggle();
                    controller.search(); // Re-run search with updated sort
                  },
                ),
              ),

              ///---- TODO -- add a tap function of this icon-
              Icon(
                Icons.av_timer_rounded,
                color: LightThemeColors.pharmacyColor,
              ),
            ],
          ),

          /// ─── Brand Dropdown ───
          Obx(
            () => DropdownField(
              label: 'Select Brand',
              items: controller.brands,
              value: controller.selectedBrand.value,
              onChanged: (val) {
                controller.selectedBrand.value = val;
                controller.clearResults();
              },
            ),
          ),

          /// ─── Manufacturer Dropdown ───
          Obx(
            () => DropdownField(
              label: 'Select Manufacturer',
              items: controller.manufacturers,
              value: controller.selectedManu.value,
              onChanged: (val) {
                controller.selectedManu.value = val;
                controller.clearResults();
              },
            ),
          ),

          /// ─── Category Dropdown ───
          Obx(
            () => DropdownField(
              label: 'Select Category',
              items: controller.categories,
              value: controller.selectedCategory.value,
              onChanged: (val) {
                controller.selectedCategory.value = val;
                controller.clearResults();
              },
            ),
          ),

          /// ─── Search Button OR "X Products found" ───
          Obx(() {
            if (controller.products.isEmpty) {
              /// Show the button if no results yet
              return Center(
                child: ElevatedButton(
                  onPressed: controller.search,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightThemeColors.pharmacyColor,
                    minimumSize: Size(screenWidth * 0.45, screenHeight * 0.06),
                  ),
                  child: const Text(
                    'Search',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            } else {
              /// Once search is done, display how many found
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  "${controller.products.length} results",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: LightThemeColors.pharmacyColor,
                  ),
                ),
              );
            }
          }),

          // const SizedBox(height: 8),

          /// ─── Product List ───
          Obx(() {
            if (controller.hasSearched.value && controller.products.isEmpty) {
              return Center(child: Text("No products found."));
            }

            final paged = controller.pagedProducts;
            return MasonryGridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              padding: const EdgeInsets.all(0),
              itemCount: paged.length,
              itemBuilder: (context, index) {
                final Product p = paged[index];
                return ProductCard(
                  product: p,
                  onBookmarkToggle: () {
                    p.isBookmarked = !p.isBookmarked;
                    // Force update so the UI refreshes
                    // (re‐assigning the same object into the RxList triggers UI update)
                    final idxGlobal = controller.products.indexOf(p);
                    controller.products[idxGlobal] = p;
                  },
                  onAddToCart: (quantity) {
                    Get.snackbar(
                      "Success",
                      "$quantity Product added to Cart",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                );
              },
            );
          }),

          /// ─── Pagination Bar (Only if more than 1 page) ───
          Obx(() {
            final totalPages = controller.totalPages;
            final current = controller.currentPage.value;

            if (controller.products.isEmpty || totalPages <= 1) {
              return const SizedBox();
            }

            // Build a list of page‐number buttons dynamically
            List<Widget> pageButtons = [];
            for (int i = 1; i <= totalPages; i++) {
              final bool isCurrent = (i == current);
              pageButtons.add(
                GestureDetector(
                  onTap: () => controller.goToPage(i),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isCurrent ? Colors.orange : Colors.grey[300],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "$i",
                      style: TextStyle(
                        color: isCurrent ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Previous Button
                GestureDetector(
                  onTap: () => controller.prevPage(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Previous",
                      style: TextStyle(
                        color: current > 1 ? Colors.black : Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),

                /// Page Number Buttons
                ...pageButtons,

                /// Next Button
                GestureDetector(
                  onTap: () => controller.nextPage(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color:
                            current < totalPages ? Colors.black : Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
