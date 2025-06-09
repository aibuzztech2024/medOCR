import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../viewModels/map/faq_controller.dart';
import '../../../widgets/faq_category_tile.dart';

class FAQView extends StatelessWidget {
  final FAQController controller = Get.put(FAQController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'FAQ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              Expanded(
                child: ListView.separated(
                  itemCount: controller.faqCategories.length,
                  separatorBuilder: (context, index) => SizedBox(height: 4),
                  itemBuilder:
                      (context, index) => FAQCategoryTile(
                        category: controller.faqCategories[index],
                      ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
