import 'dart:io';

import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../models/endcustomerhome/event_model.dart';
import '../../../../../viewModels/endcustomerhome/calender_controller.dart';
import 'event_form_sheet.dart';


/// Widget that displays a list of events for the selected day
class EventsList extends StatelessWidget {
  final CalendarController controller = Get.find();

  EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedDate = controller.selectedDate.value;

      // Filter events for the selected date
      final filteredEvents =
          controller.events.where((event) {
            return event.date.day == selectedDate.day &&
                event.date.month == selectedDate.month &&
                event.date.year == selectedDate.year;
          }).toList();

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD5D2CF)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, -2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          children: [
            if (filteredEvents.isEmpty)
              AppText.caption('No events for this date')
            else
              ...List.generate(filteredEvents.length, (index) {
                return Column(
                  children: [
                    _buildEventItem(filteredEvents[index], index),
                    if (index < filteredEvents.length - 1)
                      const SizedBox(height: 10),
                  ],
                );
              }),
          ],
        ),
      );
    });
  }

  /// Builds a single event item row
  Widget _buildEventItem(EventModel event, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Event image
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          clipBehavior: Clip.antiAlias,
          child: _buildEventImage(event.imagePath),
        ),

        const SizedBox(width: 16),

        // Event details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.heading(event.title, fontWeight: FontWeight.w600),
              const SizedBox(height: 8),
              AppText.caption(event.time, fontWeight: FontWeight.w400),
            ],
          ),
        ),

        // Edit icon
        GestureDetector(
          onTap: () {
            Get.bottomSheet(
              EventFormSheet(existingEvent: event, index: index),
              isScrollControlled: true,
            );
          },
          child: const Icon(
            Icons.mode_edit_outlined,
            size: 18,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  /// Helper for loading event images from file or assets
  Widget _buildEventImage(String imagePath) {
    if (imagePath.startsWith('/')) {
      // Load image from local file (gallery)
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.image_not_supported);
        },
      );
    } else {
      // Load image from project assets
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image);
        },
      );
    }
  }
}
