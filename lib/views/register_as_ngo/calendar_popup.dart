// =================== calendar_popup.dart ===================
import 'package:avatar/views/register_as_ngo/calendart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'calendar_controller.dart'; // Import the controller

class CalendarPopup extends StatelessWidget {
  final CalendarController controller = Get.find<CalendarController>();

  CalendarPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.75,
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
                flex: 3,
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

                              final isSelected =
                                  controller.selectedCalendarDate.value?.day ==
                                      day.day &&
                                  controller
                                          .selectedCalendarDate
                                          .value
                                          ?.month ==
                                      day.month &&
                                  controller.selectedCalendarDate.value?.year ==
                                      day.year;

                              return GestureDetector(
                                onTap: () => controller.selectCalendarDate(day),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? Color(0xFF6B79F5)
                                            : isToday
                                            ? Color(0xFF6B79F5).withOpacity(0.3)
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
                                            isSelected
                                                ? Colors.white
                                                : isToday
                                                ? Color(0xFF6B79F5)
                                                : Colors.black87,
                                        fontSize: screenWidth * 0.035,
                                        fontWeight:
                                            isSelected || isToday
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

              // Event input section
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Selected date display
                    Obx(() {
                      if (controller.selectedCalendarDate.value == null) {
                        return Text(
                          'Please select a date',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }

                      final selectedDate =
                          controller.selectedCalendarDate.value!;
                      return Text(
                        'Selected: ${controller.getDayName(selectedDate)}, ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: TextStyle(
                          color: Color(0xFF6B79F5),
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }),

                    SizedBox(height: screenHeight * 0.015),

                    // Text field for event input
                    TextField(
                      controller: controller.eventTextController,
                      maxLength: 12,
                      decoration: InputDecoration(
                        hintText: 'Enter event (max 12 chars)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Color(0xFF6B79F5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Color(0xFF6B79F5),
                            width: 2,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.015,
                        ),
                      ),
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.submitEvent(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6B79F5),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.02,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Add Event',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
