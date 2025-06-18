import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../core/widgets/expandable_text.dart';
import '../../../models/map/location_overview_model.dart';
import '../../../viewModels/map/location_review_controller.dart';

class Reviews_widget extends StatelessWidget {
  final List<ReviewComment> comments;

  Reviews_widget({super.key, required this.comments}) {
    final controller = Get.put(ReviewController());
    controller.setReviews(comments);
  }

  final filters = ['Newest', 'Highest', 'Lowest'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReviewController>();

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const Text(
              "Ratings & Reviews",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
        
            // Filter Chips
            Obx(() => Wrap(
              spacing: 8,
              children: filters.map((f) {
                final selected = controller.selectedFilter.value == f;
                return ChoiceChip(
                  label: Text(f),
                  selected: selected,
                  onSelected: (_) => controller.changeFilter(f),
                  selectedColor: Colors.orange.shade50,
                  labelStyle: TextStyle(
                      color: Colors.black),
                  side: const BorderSide(color: Colors.grey),
                );
              }).toList(),
            )),
            const SizedBox(height: 16),
        
            // Comments
            Obx(() => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.filteredComments.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (_, index) {
                final comment = controller.filteredComments[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(comment.avatarUrl),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(comment.name.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  controller.getRelativeTime(comment.date),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: List.generate(5, (i) {
                              return Icon(
                                i < comment.rating
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 16,
                                color: Colors.amber,
                              );
                            }),
                          ),
                          const SizedBox(height: 4),
                          ExpandableText(text:  comment.comment),
                        ],
                      ),
                    ),
                  ],
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

