import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/endcustomerhome/controller/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Displays a horizontal row of dates for the current week.
/// Users can tap on a date to select it. Selected date and today's date are highlighted differently.
class CalendarDaysRow extends StatelessWidget {
  final CalendarController controller = Get.find();

  CalendarDaysRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final weekDates = controller.currentWeekDates;
      final today = DateTime.now();
      final hasUserSelectedDate = controller.hasUserSelectedDate.value;
      final tomorrow = DateTime.now().add(Duration(days: 1));

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            weekDates.map((date) {
              final isToday =
                  date.day == today.day &&
                  date.month == today.month &&
                  date.year == today.year;

              final isSelected =
                  date.day == controller.selectedDate.value.day &&
                  date.month == controller.selectedDate.value.month &&
                  date.year == controller.selectedDate.value.year;

              final highlightTomorrow =
                  !hasUserSelectedDate &&
                  date.day == tomorrow.day &&
                  date.month == tomorrow.month &&
                  date.year == tomorrow.year;

              final isTodaySelected = isToday;
              final isNormalSelected =
                  (isSelected && !isToday) || highlightTomorrow;

              return GestureDetector(
                onTap:
                    () =>
                        controller.selectDate(date), // ⏺️ Update selected date
                child: Column(
                  children: [
                    // Special highlighted style for today
                    if (isTodaySelected)
                      Container(
                        width: 35,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.20),
                              offset: Offset(2, 3),
                              blurRadius: 5,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText.caption(
                              DateFormat.E().format(date)[0], // Weekday initial
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(height: 4),
                            AppText.caption(
                              '${date.day}', // Date number
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                            // Marker dot for today
                            Container(
                              height: 2,
                              width: 2,
                              decoration: BoxDecoration(
                                color: Color(0xFFF79E1B),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      // Regular dates
                      Column(
                        children: [
                          AppText.caption(
                            DateFormat.E().format(date)[0], // Weekday initial
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 27,
                            height: 27,
                            decoration: BoxDecoration(
                              color:
                                  isNormalSelected
                                      ? Colors.white
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  isNormalSelected
                                      ? Border.all(
                                        color: Colors.grey[300]!,
                                        width: 1,
                                      )
                                      : null,
                              boxShadow:
                                  isNormalSelected
                                      ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          offset: Offset(2, 3),
                                          blurRadius: 5,
                                        ),
                                      ]
                                      : [],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: AppText.caption(
                                    '${date.day}',
                                    fontWeight:
                                        isNormalSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                    fontSize: isNormalSelected ? 14 : 12,
                                  ),
                                ),
                                // Marker for selected date
                                if (isNormalSelected)
                                  Container(
                                    height: 2,
                                    width: 2,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF79E1B),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            }).toList(),
      );
    });
  }
}
