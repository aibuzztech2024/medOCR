import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/ticket/create_ticket.dart';
import 'package:avatar/viewModels/hospital/upload_issue_image_controller.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/labeled_drop_down_button.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/labeled_text_field.dart';
import 'package:avatar/views/enduserphone/share/upload_file_preview.dart';
import 'package:avatar/views/hospital/Widgets/upload_issue_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class CreateTicket extends StatelessWidget {
  CreateTicket({super.key});

  final UploadIssueImage _uploadIssueImage = Get.put(UploadIssueImage());
  final CreateTicketViewModel _viewModel = Get.put(
    CreateTicketViewModel(),
  ); // Add ViewModel

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive UI
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: const BackButton(
          color: Colors.black,
        ), // Back button in app bar
        title: const Text(
          'Create New Ticket', // Title of the page
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          // Padding around the content for proper spacing
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabeledDropdown(
                label: 'Issue Type',
                items: [],
                hintText: 'Select a type',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(75, 75, 75, 100),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              LabeledDropdown(
                label: 'Select Issue',
                items: [],
                hintText: 'Select an issue',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(75, 75, 75, 100),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              LabeledTextField(
                label: 'Describe your Issue',
                hintText: 'Please provide as much details as possible',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(75, 75, 75, 100),
                ),
                minLines: 5,
                maxLines: 5,
              ),
              SizedBox(height: screenHeight * 0.02),

              AppText(
                'Upload File',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: screenHeight * 0.02),

              UploadIssueImageWidget(controller: _uploadIssueImage),
            ],
          ),
        ),
      ),
    );
  }
}
