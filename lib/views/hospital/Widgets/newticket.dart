import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/themes/light/light_theme_colors.dart';
import '../../auth/widget/input_field.dart';
import 'package:avatar/core/widgets/height_box.dart';
import 'package:avatar/core/widgets/width_box.dart';
import 'upload_issue_image.dart';
import '../../../viewModels/hospital/upload_issue_image_controller.dart';

class NewTicketPage extends StatefulWidget {
  const NewTicketPage({super.key});

  @override
  State<NewTicketPage> createState() => _NewTicketPageState();
}

class _NewTicketPageState extends State<NewTicketPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descController = TextEditingController();
  String? _selectedType;
  String? _selectedIssue;
  String? _uploadedFileName;
  bool _virusScanned = false;

  final List<String> _issueTypes = ['Technical', 'Billing', 'Account', 'Other'];
  final List<String> _issues = [
    'App Crash',
    'Payment Failed',
    'Login Issue',
    'Other',
  ];

  final UploadIssueImage _uploadController = Get.put(UploadIssueImage());

  void _pickFile() async {
    // TODO: Implement file picker
    setState(() {
      _uploadedFileName = 'issue_image.png';
      _virusScanned = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.heading('Issue Type', fontSize: 15),
              HeightBox(8),
              Container(
                decoration: BoxDecoration(
                  color: LightThemeColors.scaffoldBackground,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: LightThemeColors.subtitleText.withOpacity(0.1),
                      offset: Offset(2, 3),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedType,
                  hint: AppText.body('Select a type'),
                  items:
                      _issueTypes
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: AppText.body(type),
                            ),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => _selectedType = val),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor: LightThemeColors.scaffoldBackground,
                  ),
                ),
              ),
              HeightBox(18),
              AppText.heading('Select Issue', fontSize: 15),
              HeightBox(8),
              Container(
                decoration: BoxDecoration(
                  color: LightThemeColors.scaffoldBackground,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: LightThemeColors.subtitleText.withOpacity(0.1),
                      offset: Offset(2, 3),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedIssue,
                  hint: AppText.body('Select a issue'),
                  items:
                      _issues
                          .map(
                            (issue) => DropdownMenuItem(
                              value: issue,
                              child: AppText.body(issue),
                            ),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => _selectedIssue = val),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor: LightThemeColors.scaffoldBackground,
                  ),
                ),
              ),
              HeightBox(18),
              AppText.heading('Describe your Issue', fontSize: 15),
              HeightBox(8),
              Container(
                decoration: BoxDecoration(
                  color: LightThemeColors.scaffoldBackground,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: LightThemeColors.subtitleText.withOpacity(0.1),
                      offset: Offset(2, 3),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: InputField(
                  hintText: 'Please Provide as much details as possible',
                  controller: _descController,
                ),
              ),
              HeightBox(18),
              AppText.heading('Upload File', fontSize: 15),
              HeightBox(8),
              UploadIssueImageWidget(
                addLabel: '+ Upload Issue Image',
                controller: _uploadController,
              ),
              HeightBox(30),
              Center(
                child: AppButton(
                  type: ButtonType.filled,
                  width: double.infinity,
                  color: Colors.orange,
                  text: 'Submit Ticket',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Submit ticket
                    }
                  },
                ),
              ),
              HeightBox(20),
            ],
          ),
        ),
      ),
    );
  }
}
