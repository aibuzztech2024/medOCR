// =================== calendar_container.dart ===================
import 'package:avatar/views/register_as_ngo/calendar_widget.dart';
import 'package:avatar/views/register_as_ngo/calendart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'calendar_controller.dart'; // Import the controller

class CalendarContainer extends StatelessWidget {
  final CalendarController controller = Get.put(CalendarController());

  CalendarContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive dimensions
    final containerHeight = screenHeight * 0.25; // 25% of screen height
    final headerHeight = screenHeight * 0.05; // 5% of screen height
    final horizontalPadding = screenWidth * 0.025; // 2.5% padding

    return Container(
      height: containerHeight,
      width: screenWidth * 0.95,
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with navigation and add button
          Container(
            height: headerHeight,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.01,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF6B79F5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenWidth * 0.05),
                topRight: Radius.circular(screenWidth * 0.05),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.previousMonth(),
                      child: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: screenWidth * 0.06,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Obx(
                      () => Text(
                        controller.currentMonthString,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    GestureDetector(
                      onTap: () => controller.nextMonth(),
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: screenWidth * 0.06,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => controller.openAddEventPopup(),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: screenWidth * 0.06,
                  ),
                ),
              ],
            ),
          ),

          // Calendar events section
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Obx(() {
                final events = controller.currentMonthEvents;

                if (events.isEmpty) {
                  // Show empty state when no events for current month
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy,
                          size: screenWidth * 0.12,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          'No events this month',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    SizedBox(height: screenHeight * 0.01),
                    ...events.asMap().entries.map((entry) {
                      int index = entry.key;
                      EventItem event = entry.value;

                      return Column(
                        children: [
                          _buildEventRow(
                            context: context,
                            day: event.day,
                            date: event.date,
                            title: event.title,
                            hasDecoration: event.hasDecoration,
                            index: index,
                          ),
                          if (index < events.length - 1)
                            SizedBox(height: screenHeight * 0.01),
                        ],
                      );
                    }).toList(),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventRow({
    required BuildContext context,
    required String day,
    required String date,
    required String title,
    required bool hasDecoration,
    required int index,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final rowHeight = screenHeight * 0.05;
    final dateContainerWidth = screenWidth * 0.12;
    final spacing = screenWidth * 0.03;
    final isSelected = controller.selectedEventIndex.value == index;
    final selectedColor = Color(0xFF6B79F5).withOpacity(0.1);
    final unselectedColor = Colors.white;

    return GestureDetector(
      onTap: () => controller.selectEvent(index),
      child: Container(
        height: rowHeight,
        child: Row(
          children: [
            // Date container
            Container(
              width: dateContainerWidth,
              height: rowHeight,
              decoration: BoxDecoration(
                color: isSelected ? selectedColor : unselectedColor,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Color(0xFF6B79F5).withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day,
                    style: TextStyle(
                      color: Color(0xFF6B79F5),
                      fontSize: screenWidth * 0.032,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      color: Color(0xFF6B79F5),
                      fontSize: screenWidth * 0.028,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: spacing),
            // Event title container
            Expanded(
              child: Container(
                height: rowHeight,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.01,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? selectedColor : unselectedColor,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Color(0xFF6B79F5).withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: screenWidth * 0.035,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
