// =================== calendar_controller.dart ===================
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

  // Text field controller for event input
  final TextEditingController eventTextController = TextEditingController();
  var selectedCalendarDate = Rxn<DateTime>(); // Store selected date from popup

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

  // Get day name from date
  String getDayName(DateTime date) {
    return dayNames[date.weekday % 7];
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

  void openAddEventPopup() {
    // Reset selected date and text field
    selectedCalendarDate.value = null;
    eventTextController.clear();

    // Show calendar popup
    popupCurrentDate.value = currentDate.value; // Sync popup with current view
    showCalendarPopup.value = true;
    print('Add event tapped - showing calendar');
  }

  void closeCalendarPopup() {
    showCalendarPopup.value = false;
    selectedCalendarDate.value = null;
    eventTextController.clear();
  }

  void selectCalendarDate(DateTime date) {
    selectedCalendarDate.value = date;
    print('Selected date: ${date.day}/${date.month}/${date.year}');
  }

  void submitEvent() {
    if (selectedCalendarDate.value == null ||
        eventTextController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a date and enter event text',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (eventTextController.text.trim().length > 12) {
      Get.snackbar(
        'Error',
        'Event text must be 12 characters or less',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final selectedDate = selectedCalendarDate.value!;
    final eventText = eventTextController.text.trim();

    // Create month key
    String monthKey = '${selectedDate.month}-${selectedDate.year}';

    // Create new event
    EventItem newEvent = EventItem(
      day: getDayName(selectedDate),
      date: selectedDate.day.toString(),
      title: eventText,
      hasDecoration: false,
    );

    // Add event to the appropriate month
    if (eventsByMonth.containsKey(monthKey)) {
      eventsByMonth[monthKey]!.add(newEvent);
    } else {
      eventsByMonth[monthKey] = [newEvent];
    }

    // Sort events by date
    eventsByMonth[monthKey]!.sort(
      (a, b) => int.parse(a.date).compareTo(int.parse(b.date)),
    );

    // Update current date to show the month where event was added
    currentDate.value = DateTime(selectedDate.year, selectedDate.month, 1);

    // Close popup and show success message
    closeCalendarPopup();

    Get.snackbar(
      'Success',
      'Event added successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    print(
      'Event added: $eventText on ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
    );
  }

  void selectEvent(int index) {
    selectedEventIndex.value = index;
  }

  @override
  void onClose() {
    eventTextController.dispose();
    super.onClose();
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
