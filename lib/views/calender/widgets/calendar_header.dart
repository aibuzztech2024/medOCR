import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/calender/controller/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Widget that displays the month header with navigation and add-event button
class CalendarHeader extends StatelessWidget {
  final CalendarController controller = Get.find();

  CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Month navigation section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Previous month arrow
            GestureDetector(
              onTap: () => controller.previousMonth(),
              child: Icon(Icons.chevron_left, size: 18, color: Colors.black),
            ),

            // Current month display (reactive)
            Obx(
              () => AppText.heading(
                controller.currentMonth,
                fontWeight: FontWeight.w700,
              ),
            ),

            // Next month arrow
            GestureDetector(
              onTap: () => controller.nextMonth(),
              child: Icon(Icons.chevron_right, size: 18, color: Colors.black),
            ),
          ],
        ),

        // Add event button
        GestureDetector(
          onTap: () => controller.addEvent(),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15), // Soft shadow
                  offset: Offset(0, 2),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Icon(Icons.add, size: 24, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
