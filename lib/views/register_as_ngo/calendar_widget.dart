import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  // Use DateTime to track current month
  var currentDate = DateTime.now().obs;
  var selectedDate = 0.obs;
  var selectedEventIndex = (-1).obs;
  var showCalendarPopup = false.obs;
  var popupCurrentDate =
      DateTime.now().obs; // Separate date for popup navigation

  // Month names array
  final List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  // Day names array
  final List<String> dayNames = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  // Events data - organized by month and year
  final Map<String, List<EventItem>> eventsByMonth = {
    '6-2025': [
      // June 2025
      EventItem(
        day: 'Fri',
        date: '15',
        title: 'Nothing else today',
        hasDecoration: false,
      ),
      EventItem(
        day: 'Sat',
        date: '16',
        title: 'Meeting with Sir',
        hasDecoration: false,
      ),
      EventItem(
        day: 'Sun',
        date: '17',
        title: 'Buddha Purnima',
        hasDecoration: true,
      ),
    ],
    // Add more months as needed
    // '7-2025': [], // July 2025 - empty for now
    // '5-2025': [], // May 2025 - empty for now
  };

  // Get formatted month string
  String get currentMonthString {
    return '${monthNames[currentDate.value.month - 1]} ${currentDate.value.year}';
  }

  // Get formatted month string for popup
  String get popupMonthString {
    return '${monthNames[popupCurrentDate.value.month - 1]} ${popupCurrentDate.value.year}';
  }

  // Get events for current month
  List<EventItem> get currentMonthEvents {
    String monthKey = '${currentDate.value.month}-${currentDate.value.year}';
    return eventsByMonth[monthKey] ?? [];
  }

  // Get calendar days for popup
  List<DateTime?> getCalendarDays(DateTime date) {
    List<DateTime?> days = [];

    // Get first day of the month
    DateTime firstDay = DateTime(date.year, date.month, 1);

    // Get last day of the month
    DateTime lastDay = DateTime(date.year, date.month + 1, 0);

    // Add empty days for the beginning of the month
    int firstWeekday = firstDay.weekday % 7; // Convert to 0-6 (Sun-Sat)
    for (int i = 0; i < firstWeekday; i++) {
      days.add(null);
    }

    // Add all days of the month
    for (int day = 1; day <= lastDay.day; day++) {
      days.add(DateTime(date.year, date.month, day));
    }

    return days;
  }

  void previousMonth() {
    currentDate.value = DateTime(
      currentDate.value.year,
      currentDate.value.month - 1,
      1,
    );
    print('Previous month: ${currentMonthString}');
  }

  void nextMonth() {
    currentDate.value = DateTime(
      currentDate.value.year,
      currentDate.value.month + 1,
      1,
    );
    print('Next month: ${currentMonthString}');
  }

  void previousPopupMonth() {
    popupCurrentDate.value = DateTime(
      popupCurrentDate.value.year,
      popupCurrentDate.value.month - 1,
      1,
    );
  }

  void nextPopupMonth() {
    popupCurrentDate.value = DateTime(
      popupCurrentDate.value.year,
      popupCurrentDate.value.month + 1,
      1,
    );
  }

  void addEvent() {
    // Show calendar popup
    popupCurrentDate.value = currentDate.value; // Sync popup with current view
    showCalendarPopup.value = true;
    print('Add event tapped - showing calendar');
  }

  void closeCalendarPopup() {
    showCalendarPopup.value = false;
  }

  void selectCalendarDate(DateTime date) {
    selectedDate.value = date.day;
    print('Selected date: ${date.day}/${date.month}/${date.year}');
    // Here you can add logic to create an event for the selected date
    closeCalendarPopup();
  }

  void selectEvent(int index) {
    selectedEventIndex.value = index;
  }
}

// Event data model
class EventItem {
  final String day;
  final String date;
  final String title;
  final bool hasDecoration;

  EventItem({
    required this.day,
    required this.date,
    required this.title,
    required this.hasDecoration,
  });
}

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

    return Stack(
      children: [
        Container(
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
                      onTap: () => controller.addEvent(),
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
        ),

        // Calendar Popup
        Obx(() {
          if (!controller.showCalendarPopup.value) return SizedBox.shrink();

          return _buildCalendarPopup(context);
        }),
      ],
    );
  }

  Widget _buildCalendarPopup(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Popup Header
              Container(
                height: screenHeight * 0.08,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                          onTap: () => controller.previousPopupMonth(),
                          child: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: screenWidth * 0.07,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.04),
                        Obx(
                          () => Text(
                            controller.popupMonthString,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.04),
                        GestureDetector(
                          onTap: () => controller.nextPopupMonth(),
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: screenWidth * 0.07,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => controller.closeCalendarPopup(),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: screenWidth * 0.06,
                      ),
                    ),
                  ],
                ),
              ),

              // Calendar Grid
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    children: [
                      // Day headers
                      Row(
                        children:
                            controller.dayNames.map((day) {
                              return Expanded(
                                child: Center(
                                  child: Text(
                                    day,
                                    style: TextStyle(
                                      color: Color(0xFF6B79F5),
                                      fontSize: screenWidth * 0.035,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // Calendar days
                      Expanded(
                        child: Obx(() {
                          final days = controller.getCalendarDays(
                            controller.popupCurrentDate.value,
                          );

                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7,
                                  childAspectRatio: 1.0,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4,
                                ),
                            itemCount: days.length,
                            itemBuilder: (context, index) {
                              final day = days[index];

                              if (day == null) {
                                return SizedBox.shrink();
                              }

                              final isToday =
                                  DateTime.now().day == day.day &&
                                  DateTime.now().month == day.month &&
                                  DateTime.now().year == day.year;

                              return GestureDetector(
                                onTap: () => controller.selectCalendarDate(day),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        isToday
                                            ? Color(0xFF6B79F5)
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFF6B79F5).withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${day.day}',
                                      style: TextStyle(
                                        color:
                                            isToday
                                                ? Colors.white
                                                : Colors.black87,
                                        fontSize: screenWidth * 0.035,
                                        fontWeight:
                                            isToday
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
