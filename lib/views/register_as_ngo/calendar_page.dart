import 'package:avatar/views/register_as_ngo/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarController controller = Get.put(CalendarController());
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: Column(
        children: [
          Text('Calendar'),
          const SizedBox(height: 90),
          CalendarContainer(),
        ],
      ),
    );
  }
}
