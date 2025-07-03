import 'package:avatar/viewModels/hospital/upload_issue_image_controller.dart';
import 'package:avatar/viewModels/ticket/email_support_view_model.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/labeled_text_field.dart';
import 'package:avatar/views/hospital/Widgets/upload_issue_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailSupportView extends StatelessWidget {
  EmailSupportView({super.key});

  final UploadIssueImage _uploadIssueImage = Get.put(UploadIssueImage());
  final EmailSupportViewModel _viewModel = Get.put(
    EmailSupportViewModel(),
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
          'Email Support', // Updated title
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        // Add send button in app bar
        actions: [
          Obx(
            () =>
                _viewModel.isLoading.value
                    ? Container(
                      margin: EdgeInsets.all(16),
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : TextButton(
                      onPressed: _viewModel.sendSupportEmail,
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          // Add proper spacing like CreateTicket
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email Address Field
              LabeledTextField(
                label: 'Email Address',
                onChanged: _viewModel.onEmailChanged,
                hintText: 'contactsupport@gmail.com',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(75, 75, 75, 100),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Description Field
              LabeledTextField(
                label: 'Description',
                onChanged: _viewModel.onDescriptionChanged,
                hintText: 'Please provide as much details as possible',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(75, 75, 75, 100),
                ),
                minLines: 4,
                maxLines: 4,
              ),
              SizedBox(height: screenHeight * 0.02),

              // Upload Widget
              UploadIssueImageWidget(controller: _uploadIssueImage),

              SizedBox(height: screenHeight * 0.03),

              // Optional: Add a reset button
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _viewModel.resetForm,
                  child: Text('Reset Form'),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
