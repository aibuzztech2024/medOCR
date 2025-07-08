import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AdvisorCalendarController extends GetxController {
  var currentDate = DateTime(2024, 5).obs;
  var selectedDate = DateTime(2024, 5, 15).obs;

  // Month and day names
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
  final List<String> dayNames = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  // Example static events: Map<yyyy-mm-dd, List<String>>
  final RxMap<String, List<String>> events =
      <String, List<String>>{
        '2024-05-15': ['Nothing else today'],
        '2024-05-16': ['Meeting with Sir'],
        '2024-05-17': ['Buddha Purnima'],
      }.obs;

  String get currentMonthString =>
      '${monthNames[currentDate.value.month - 1]} ${currentDate.value.year}';

  // Returns a list of DateTime? for the calendar grid (null for empty slots)
  List<DateTime?> getCalendarDays() {
    final date = currentDate.value;
    List<DateTime?> days = [];
    DateTime firstDay = DateTime(date.year, date.month, 1);
    DateTime lastDay = DateTime(date.year, date.month + 1, 0);
    int firstWeekday = firstDay.weekday % 7;
    for (int i = 0; i < firstWeekday; i++) {
      days.add(null);
    }
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
  }

  void nextMonth() {
    currentDate.value = DateTime(
      currentDate.value.year,
      currentDate.value.month + 1,
      1,
    );
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  List<String> getEventsForDate(DateTime date) {
    final key =
        '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return events[key] ?? [];
  }

  void addTaskForDate(DateTime date, String task) {
    final key =
        '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    if (events.containsKey(key)) {
      events[key] = List.from(events[key]!)..add(task);
    } else {
      events[key] = [task];
    }
    events.refresh();
  }
}
