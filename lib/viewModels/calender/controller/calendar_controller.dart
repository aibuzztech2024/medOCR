import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:avatar/models/calender/event_model.dart';

class CalendarController extends GetxController {
  /// Currently selected date in the calendar
  var selectedDate = DateTime.now().obs;

  // Flag to indicate if user has selected a date explicitly
  var hasUserSelectedDate = false.obs;

  /// List of events for the selected date/week
  var events = <EventModel>[].obs;

  /// Returns the month and year in "MMMM yyyy" format based on selectedDate
  String get currentMonth => DateFormat("MMMM yyyy").format(selectedDate.value);

  /// Returns a list of 7 dates representing the current week (Sunday to Saturday)
  List<DateTime> get currentWeekDates {
    final now = selectedDate.value;
    // Calculate the start of the week (Sunday)
    final startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    return List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
  }

  @override
  void onInit() {
    super.onInit();
    loadEvents(); // Load initial events (hardcoded for now)
  }

  /// Loads events into the controller (currently hardcoded for demo)
  void loadEvents() {
    events.value = [
      EventModel(
        title: "Regulatory Deadlines",
        time: "8:00 - 8:15 AM",
        imagePath: "assets/images/calender2.jpg",
      ),
      EventModel(
        title: "Inventory Check",
        time: "11:00 - 2:15 PM",
        imagePath: "assets/images/calender1.jpg",
      ),
    ];
  }

  /// Called when a date is selected from the calendar UI
  void selectDate(DateTime date) {
    selectedDate.value = date;
    hasUserSelectedDate.value = true; // User selected date explicitly

    // TODO: Fetch events from backend API for the selected date
    // e.g., fetchEventsForDate(date);
  }

  /// Navigate to the previous month
  void previousMonth() {
    // TODO: Update selectedDate to previous month
    // selectedDate.value = DateTime(selectedDate.value.year, selectedDate.value.month - 1, 1);

    // TODO: Fetch updated month events from backend after change
  }

  /// Navigate to the next month
  void nextMonth() {
    // TODO: Update selectedDate to next month
    // selectedDate.value = DateTime(selectedDate.value.year, selectedDate.value.month + 1, 1);

    // TODO: Fetch updated month events from backend after change
  }

  /// Handler to add a new event
  void addEvent() {
    // TODO: Open a UI or route to add a new event

    // TODO: After adding event, refresh the event list from backend
  }

  // TODO: Implement the actual event fetching logic from your backend API
  // Future<void> fetchEventsForDate(DateTime date) async {
  //   final fetchedEvents = await yourApiService.getEvents(date);
  //   events.value = fetchedEvents;
  // }
}
