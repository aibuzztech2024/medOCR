import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/endcustomerhome/controller/calendar_controller.dart';
import 'package:avatar/views/endcustomerhome/widget/calendar_days_row.dart';
import 'package:avatar/views/endcustomerhome/widget/calendar_header.dart';
import 'package:avatar/views/endcustomerhome/widget/events_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Main widget for displaying upcoming calendar events.
class UpcomingEventsWidget extends StatelessWidget {
  /// Injecting CalendarController using GetX
  final CalendarController controller = Get.put(CalendarController());

  UpcomingEventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header: Title of the screen
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppText.heading(
            'Upcoming Events',
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 12),

        /// Calendar Header and Days Row wrapped in gradient background
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFEFAF3), // Light creamy background
                Color(0x26F79E1B), // Light orange overlay (10% opacity)
              ],
            ),
            border: const Border(
              top: BorderSide(color: Color(0x26F79E1B), width: 1),
              left: BorderSide(color: Color(0x26F79E1B), width: 1),
              right: BorderSide(color: Color(0x26F79E1B), width: 1),
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              /// Top row showing current month, nav arrows
              CalendarHeader(),

              const SizedBox(height: 16),

              /// Days of the current week
              CalendarDaysRow(),
            ],
          ),
        ),

        /// List of events for selected date
        ///
        /// TODO: Integrate this section with backend
        /// - Fetch events from API based on selected date
        /// - Bind data using GetX (observable list in CalendarController)
        /// - Show loading indicator while fetching
        /// - Handle empty state when no events exist
        EventsList(),
      ],
    );
  }
}
