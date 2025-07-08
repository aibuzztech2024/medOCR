import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../viewModels/register_advisor/calendar_controller.dart';

class TasksCalendar extends StatelessWidget {
  TasksCalendar({Key? key}) : super(key: key);
  final AdvisorCalendarController controller = Get.put(
    AdvisorCalendarController(),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text(
              'Your Tasks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red.shade100, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.shade100.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 8),
                  _buildTaskList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.red.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.white),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: controller.previousMonth,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Center(
                child: Text(
                  controller.currentMonthString,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2),
            IconButton(
              icon: const Icon(Icons.chevron_right, color: Colors.white),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: controller.nextMonth,
            ),
            Container(
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.red),
                onPressed: () => _showAddTaskSheet(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTaskSheet(BuildContext context) {
    final TextEditingController taskController = TextEditingController();
    final List<DateTime> days =
        controller.getCalendarDays().whereType<DateTime>().toList();
    DateTime selectedDate;
    if (!days.contains(controller.selectedDate.value)) {
      selectedDate = days.first;
    } else {
      selectedDate = controller.selectedDate.value;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add Task',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<DateTime>(
                    value: selectedDate,
                    decoration: const InputDecoration(
                      labelText: 'Select Date',
                      border: OutlineInputBorder(),
                    ),
                    items:
                        days.map((date) {
                          final weekday = controller.dayNames[date.weekday % 7];
                          return DropdownMenuItem<DateTime>(
                            value: date,
                            child: Text(
                              '$weekday, ${date.day} ${controller.monthNames[date.month - 1]}',
                            ),
                          );
                        }).toList(),
                    onChanged: (date) {
                      if (date != null) setState(() => selectedDate = date);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      labelText: 'Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        final text = taskController.text.trim();
                        if (text.isNotEmpty) {
                          controller.addTaskForDate(selectedDate, text);
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Add Task'),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTaskList() {
    return Obx(() {
      final current = controller.currentDate.value;
      final events =
          controller.events.entries.where((entry) {
              final date = DateTime.parse(entry.key);
              return date.year == current.year && date.month == current.month;
            }).toList()
            ..sort((a, b) => a.key.compareTo(b.key));

      if (events.isEmpty) {
        return Container(
          margin: const EdgeInsets.only(top: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'No tasks for this month',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }

      return Column(
        children:
            events.map((entry) {
              final date = DateTime.parse(entry.key);
              final weekday = controller.dayNames[date.weekday % 7];
              final day = date.day;
              final tasks = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 56,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            weekday,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            day.toString(),
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            tasks
                                .map(
                                  (task) => Container(
                                    margin: const EdgeInsets.only(bottom: 6),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      task,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      );
    });
  }
}
