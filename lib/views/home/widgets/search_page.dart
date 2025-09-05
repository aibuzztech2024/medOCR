import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// MODEL: Simple model for search item
class SearchModel {
  final String title;
  SearchModel({required this.title});
}

/// VIEWMODEL: Manages search logic and state
class SearchViewModel extends GetxController {
  final isTapped = false.obs;       // Tracks if search box is active/tapped
  final searchText = ''.obs;        // Stores current search input text

  // All possible search results (dummy data)
  final List<SearchModel> allResults = [
    SearchModel(title: "Purchase"),
    SearchModel(title: "Purchase History"),
    SearchModel(title: "Purchase Search"),
  ];

  // Filtered results shown in UI, reactive list
  final filteredResults = <SearchModel>[].obs;

  /// Called when search box is tapped/activated
  void activateSearch() {
    isTapped.value = true;
    filteredResults.value = allResults;
  }

  /// Called when clear (close) icon is tapped
  void clearSearch() {
    searchText.value = '';
    isTapped.value = false;
  }

  /// Filters results based on input query
  void filterResults(String query) {
    if (query.isEmpty) {
      filteredResults.value = allResults;
    } else {
      filteredResults.value = allResults
          .where((item) =>
          item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  /// Called when user taps on a search result item
  void selectResult(SearchModel selected) {
    searchText.value = selected.title;     // Autofill search box
    filterResults(selected.title);         // Optional: refine results
    isTapped.value = false;                // 🔥 Hide the dropdown after selection
  }
}

/// MAIN SEARCH PAGE UI
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchViewModel());

    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth > 600 ? 600.0 : screenWidth * 0.9;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Search Bar Container
                Container(
                  width: containerWidth,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8EF),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: Colors.orange,
                        size: 24,
                      ),
                      const SizedBox(width: 6),

                      /// Search TextField wrapped in GestureDetector
                      Expanded(
                        child: GestureDetector(
                          onTap: controller.activateSearch,
                          child: Obx(() {
                            return TextField(
                              enabled: controller.isTapped.value,
                              controller: TextEditingController(
                                  text: controller.searchText.value)
                                ..selection = TextSelection.fromPosition(
                                  TextPosition(
                                      offset:
                                      controller.searchText.value.length),
                                ),
                              onChanged: (value) {
                                controller.searchText.value = value;
                                controller.filterResults(value);
                              },
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                height: 1.2,
                                letterSpacing: 0.0,
                                color: Colors.black87,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                hintText: 'Search.....',
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            );
                          }),
                        ),
                      ),

                      /// Clear (X) icon shown only when search is active
                      Obx(() {
                        return controller.isTapped.value
                            ? GestureDetector(
                          onTap: controller.clearSearch,
                          child: const Icon(
                            Icons.close,
                            color: Colors.black87,
                            size: 20,
                          ),
                        )
                            : const SizedBox.shrink();
                      }),
                    ],
                  ),
                ),

                /// Results Box below Search Bar, shown only when search is active
                Obx(() {
                  if (!controller.isTapped.value) return const SizedBox.shrink();

                  return Container(
                    width: containerWidth,
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFEBEBEB),
                        width: 1,
                      ),
                    ),
                    child: controller.filteredResults.isEmpty
                        ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "No results found",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    )
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.filteredResults.length,
                      itemBuilder: (context, index) {
                        final item = controller.filteredResults[index];
                        return GestureDetector(
                          onTap: () {
                            controller.selectResult(item);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: Text(
                              item.title,
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                height: 1.2,
                                letterSpacing: 0.0,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
