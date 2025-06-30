import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/models/endcustomer/event_model.dart';
import 'package:avatar/viewModels/endcustomer/controller/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Widget that displays a list of events for the selected day
class EventsList extends StatelessWidget {
  final CalendarController controller = Get.find();

  EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFD5D2CF)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), // Subtle shadow
            offset: Offset(0, -2),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),

      /// Reactive UI that updates when the event list changes
      child: Obx(() {
        final events = controller.events;

        // TODO: Add loading indicator or empty state message if needed
        return Column(
          children: List.generate(events.length, (index) {
            return Column(
              children: [
                _buildEventItem(events[index]),
                if (index < events.length - 1) SizedBox(height: 10),
              ],
            );
          }),
        );
      }),
    );
  }

  /// Builds a single event item row
  Widget _buildEventItem(EventModel event) {
    return Row(
      children: [
        // Event icon
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(event.imagePath, fit: BoxFit.cover),

          // TODO: If using network images from backend, replace with Image.network
        ),

        SizedBox(width: 16),

        // Event details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.heading(event.title, fontWeight: FontWeight.w600),
              SizedBox(height: 8),
              AppText.caption(event.time, fontWeight: FontWeight.w400),
            ],
          ),
        ),

        // Edit icon
        GestureDetector(
          onTap: () {
            // TODO: Implement edit event functionality
            // Possibly open a bottom sheet or new screen to edit event data
          },
          child: Icon(Icons.mode_edit_outlined, size: 18, color: Colors.black),
        ),
      ],
    );
  }
}
