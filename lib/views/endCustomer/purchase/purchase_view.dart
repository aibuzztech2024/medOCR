import 'package:avatar/views/endCustomer/purchase/widgets/dropdownfield.dart';
import 'package:avatar/views/endCustomer/purchase/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/endCustomer/purchase/product_modal.dart';
import '../../../viewModels/endCustomer/purchase/search_controller.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(searchTabController());

    return Scaffold(
      appBar: AppBar(title: const Text("Purchase")),
      body: Column(
        children: [
          TabBar(
            dividerHeight: 0.0,
            controller: _tabController,
            labelColor: Colors.orange,
            indicatorColor: Colors.orange,
            tabs: const [Tab(text: "Search"), Tab(text: "Submit Request"), Tab(text: "Order Discussion")],
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,

              children: [_SearchTab(), Center(child: Text("Submit Request")), Center(child: Text("Order Discussion"))],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchTab extends StatelessWidget {
  const _SearchTab();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<searchTabController>();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                  child: TextField(
                    decoration: InputDecoration(
                      isCollapsed: true,

                      hintText: 'Search by medicine name or categories',
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
              Obx(() => IconButton(
                icon: Icon(
                  controller.sortByBookmark.value ? Icons.bookmark : Icons.bookmark_border,
                  color:Colors.orange ,
                ),
                onPressed: () {
                  controller.sortByBookmark.toggle();
                  controller.search(); // Re-run search with updated sort
                },
              )),
              Icon(Icons.av_timer_rounded, color: Colors.orange),
            ],
          ),
          const SizedBox(height: 12),
          // ─── Brand Dropdown ───
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

          const SizedBox(height: 12),

          // ─── Manufacturer Dropdown ───
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

          const SizedBox(height: 12),

          // ─── Category Dropdown ───
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

          const SizedBox(height: 12),

          // ─── Search Button OR "X Products found" ───
          Obx(() {
            if (controller.products.isEmpty) {
              // Show the button if no results yet
              return Center(
                child: ElevatedButton(
                  onPressed: controller.search,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, minimumSize: Size(screenWidth * 0.45, screenHeight * 0.06)),
                  child: const Text('Search', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              );
            } else {
              // Once search is done, display how many found
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  "${controller.products.length} results",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange),
                ),
              );
            }
          }),

          const SizedBox(height: 20),
          // ─── Product List ───
          Obx(() {
            if (controller.hasSearched.value && controller.products.isEmpty) {
              return Center(child: Text("No products found."));
            }

            final paged = controller.pagedProducts;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                );
              },
            );
          }),

          // ─── Pagination Bar (Only if more than 1 page) ───
          const SizedBox(height: 12),
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
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(color: isCurrent ? Colors.orange : Colors.grey[300], borderRadius: BorderRadius.circular(6)),
                    child: Text("$i", style: TextStyle(color: isCurrent ? Colors.white : Colors.black87, fontWeight: FontWeight.w600)),
                  ),
                ),
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Previous Button
                GestureDetector(
                  onTap: () => controller.prevPage(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("Previous", style: TextStyle(color: current > 1 ? Colors.black : Colors.grey, fontSize: 14)),
                  ),
                ),

                // Page Number Buttons
                ...pageButtons,

                // Next Button
                GestureDetector(
                  onTap: () => controller.nextPage(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("Next", style: TextStyle(color: current < totalPages ? Colors.black : Colors.grey, fontSize: 14)),
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
