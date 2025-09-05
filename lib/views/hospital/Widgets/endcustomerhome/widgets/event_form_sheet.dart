import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../models/endcustomerhome/event_model.dart';
import '../../../../../viewModels/endcustomerhome/calender_controller.dart';


class EventFormSheet extends StatefulWidget {
  final EventModel? existingEvent;
  final int? index;

  const EventFormSheet({this.existingEvent, this.index, super.key});

  @override
  State<EventFormSheet> createState() => _EventFormSheetState();
}

class _EventFormSheetState extends State<EventFormSheet> {
  final CalendarController controller = Get.find();

  late TextEditingController titleController;
  late TextEditingController timeController;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
      text: widget.existingEvent?.title ?? '',
    );
    timeController = TextEditingController(
      text: widget.existingEvent?.time ?? '',
    );
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  void saveEvent() {
    final newEvent = EventModel(
      title: titleController.text,
      time: timeController.text,
      imagePath:
          selectedImage?.path ??
          widget.existingEvent?.imagePath ??
          'assets/images/default.png',
      date: controller.selectedDate.value,
    );

    if (widget.index != null) {
      controller.updateEvent(widget.index!, newEvent);
    } else {
      controller.addNewEvent(newEvent);
    }

    Get.back();
  }

  void deleteEvent() {
    if (widget.index != null) {
      controller.deleteEvent(widget.index!);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            Text(
              widget.index != null ? 'Edit Event' : 'Add Event',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),

            GestureDetector(
              onTap: pickImage,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    selectedImage != null
                        ? Image.file(selectedImage!, fit: BoxFit.cover)
                        : (widget.existingEvent != null
                            ? Image.asset(
                              widget.existingEvent!.imagePath,
                              fit: BoxFit.cover,
                            )
                            : Icon(
                              Icons.add_a_photo,
                              size: 32,
                              color: Colors.grey[600],
                            )),
              ),
            ),

            SizedBox(height: 16),

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Event Title',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 12),

            TextField(
              controller: timeController,
              decoration: InputDecoration(
                labelText: 'Event Time (e.g., 10:00 - 11:00 AM)',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.index != null)
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: deleteEvent,
                    icon: Icon(Icons.delete),
                    label: Text('Delete'),
                  ),
                ElevatedButton.icon(
                  onPressed: saveEvent,
                  icon: Icon(Icons.save),
                  label: Text(widget.index != null ? 'Update' : 'Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
