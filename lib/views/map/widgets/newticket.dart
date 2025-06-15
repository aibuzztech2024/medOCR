import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/themes/light/light_theme_colors.dart';
import '../../../views/auth/widget/input_field.dart';
import 'package:avatar/core/widgets/height_box.dart';
import 'package:avatar/core/widgets/width_box.dart';

class NewTicketPage extends StatefulWidget {
  const NewTicketPage({Key? key}) : super(key: key);

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
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: _pickFile,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.add,
                                color: LightThemeColors.orangeicon,
                                size: 28,
                              ),
                            ),
                          ),
                          WidthBox(12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.body(
                                '+ Upload Issue Image',
                                fontWeight: FontWeight.w600,
                              ),
                              HeightBox(2),
                              AppText.caption(
                                'Accepts: JPG, PNG, PDF ( Max 15MB )',
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (_uploadedFileName != null) ...[
                        HeightBox(16),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: LightThemeColors.inputFill,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: LightThemeColors.orangeicon,
                                size: 20,
                              ),
                              WidthBox(6),
                              AppText.body(_uploadedFileName!),
                            ],
                          ),
                        ),
                      ],
                      HeightBox(8),
                      Row(
                        children: [
                          AppText.caption('Virus scan'),
                          WidthBox(4),
                          Icon(
                            _virusScanned
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: Colors.green,
                            size: 18,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
