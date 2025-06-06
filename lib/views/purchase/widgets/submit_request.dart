import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

// Submit Request Page using GetX and responsive layout
class SubmitRequestPage extends StatelessWidget {
  SubmitRequestPage({Key? key}) : super(key: key);

  // Reactive variables for form fields
  final RxString doctorName = ''.obs;
  final RxString patientName = ''.obs;

  @override
  Widget build(BuildContext context) {
    final width = Get.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Submit Request",
          style: TextStyle(fontSize: width * 0.05),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor’s Name Input
            TextField(
              decoration: InputDecoration(
                labelText: "Doctor’s Name",
                labelStyle: TextStyle(fontSize: width * 0.042),
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                contentPadding: EdgeInsets.only(left: 0, bottom: 8),
              ),
              onChanged: (value) => doctorName.value = value,
            ),
            SizedBox(height: width * 0.05),

            // Patient’s Name Input
            TextField(
              decoration: InputDecoration(
                labelText: "Patient’s Name",
                labelStyle: TextStyle(fontSize: width * 0.042),
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                contentPadding: EdgeInsets.only(left: 0, bottom: 8),
              ),
              onChanged: (value) => patientName.value = value,
            ),

            SizedBox(height: width * 0.08),

            // Upload Section
            GestureDetector(
              onTap: () {
                // TODO: Add upload functionality
              },
              child: DottedBorder(
                color: Colors.orange,
                strokeWidth: 1,
                dashPattern: [8, 4],
                borderType: BorderType.RRect,
                radius: Radius.circular(6),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: width * 0.08),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_upload_outlined,
                          color: Colors.orange, size: width * 0.1),
                      SizedBox(height: width * 0.02),
                      Text(
                        "Upload Image or record audio, & video",
                        style: TextStyle(
                          fontSize: width * 0.042,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: width * 0.08),
          ],
        ),
      ),
    );
  }
}
