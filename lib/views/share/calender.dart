/*
  Packages Used
  - intl: For formatting month names (e.g., Jan, Feb, etc.)
  - No other external packages used — only Flutter's core material and cupertino libraries.
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Entry screen that displays a button to open the custom date picker dialog
/// and shows the selected date below the button.
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String date = ''; // Holds the selected date string

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Date Picker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Show the custom date picker dialog
                showCustomDatePicker(context, (pickedDate) {
                  // Update the displayed date when user confirms selection
                  setState(() {
                    date = pickedDate;
                  });
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Choose a date'),
              ),
            ),
            const SizedBox(height: 20),
            // Display the selected date or a prompt if no date is chosen
            Text(
              date.isEmpty ? 'Pick a date' : date,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

/// Function to display the custom date picker dialog
/// [onDatePicked] is a callback to return the picked date as string
void showCustomDatePicker(BuildContext context, Function(String) onDatePicked) {
  // Initialize to current date
  int selectedDay = DateTime.now().day;
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  // Generate abbreviated month names (Jan, Feb, etc.)
  final List<String> monthNames = List.generate(12, (index) {
    return DateFormat.MMM().format(DateTime(0, index + 1));
  });

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 240,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: StatefulBuilder(
              builder: (context, setState) {
                // Calculate number of days in the selected month/year
                int daysInMonth =
                    DateTime(selectedYear, selectedMonth + 1, 0).day;

                // Adjust day if selected day is greater than days in month
                if (selectedDay > daysInMonth) {
                  selectedDay = daysInMonth;
                }

                return Column(
                  children: [
                    // The row of pickers: day, month, year
                    Expanded(
                      child: Row(
                        children: [
                          // Day picker (1 - max days in month)
                          _buildPickerWithDividers(
                            child: CupertinoPicker(
                              looping: true, // Allows infinite scrolling
                              selectionOverlay:
                                  null, // Removes default highlight
                              scrollController: FixedExtentScrollController(
                                initialItem: selectedDay - 1,
                              ),
                              itemExtent: 36, // Height of each item
                              onSelectedItemChanged: (index) {
                                setState(() {
                                  selectedDay = (index % daysInMonth) + 1;
                                });
                              },
                              children: List.generate(daysInMonth, (index) {
                                return Center(
                                  child: Text(
                                    (index + 1).toString().padLeft(2, '0'),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          // Month picker (Jan - Dec)
                          _buildPickerWithDividers(
                            child: CupertinoPicker(
                              looping: true,
                              selectionOverlay: null,
                              scrollController: FixedExtentScrollController(
                                initialItem: selectedMonth - 1,
                              ),
                              itemExtent: 36,
                              onSelectedItemChanged: (index) {
                                setState(() {
                                  selectedMonth = (index % 12) + 1;
                                });
                              },
                              children:
                                  monthNames.map((name) {
                                    return Center(
                                      child: Text(
                                        name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                          // Year picker (2022 - 2026)
                          _buildPickerWithDividers(
                            child: CupertinoPicker(
                              looping: true,
                              selectionOverlay: null,
                              scrollController: FixedExtentScrollController(
                                initialItem: selectedYear - 2022,
                              ),
                              itemExtent: 36,
                              onSelectedItemChanged: (index) {
                                setState(() {
                                  selectedYear = 2022 + (index % 5);
                                });
                              },
                              children: List.generate(5, (index) {
                                return Center(
                                  child: Text(
                                    '${2022 + index}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Action buttons: Cancel and OK
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Cancel button closes dialog
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.orange.shade50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        // OK button sends picked date back and closes dialog
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            // Format date string as day-month-year
                            String pickedDate =
                                '$selectedDay-$selectedMonth-$selectedYear';
                            // Pass date back to caller
                            onDatePicked(pickedDate);
                            debugPrint('Selected: $pickedDate');
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    },
  );
}

/// Helper that wraps the picker and adds horizontal dividers at center
Widget _buildPickerWithDividers({required Widget child}) {
  return Expanded(
    child: Stack(
      children: [
        child,
        const IgnorePointer(
          child: Column(
            children: [
              Spacer(flex: 1),
              Divider(
                thickness: 1.5,
                color: Color.fromARGB(255, 72, 72, 72),
                indent: 15,
                endIndent: 15,
              ),
              SizedBox(height: 34), // Matches itemExtent height
              Divider(
                thickness: 1.5,
                color: Color.fromARGB(255, 72, 72, 72),
                indent: 15,
                endIndent: 15,
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      ],
    ),
  );
}
