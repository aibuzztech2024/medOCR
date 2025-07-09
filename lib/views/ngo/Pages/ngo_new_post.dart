import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../widgets/ngo_bottom_buttons.dart';
import '../widgets/ngo_tab_bar.dart';
import 'package:intl/intl.dart';

// Model for a new NGO post.
class NewPostModel {
  String header;
  String description;
  List<String> tags;
  String targetDonation;
  String donationFrequency;
  String country;
  String state;
  String city;
  String age;
  String gender;
  String spendingPower;
  String validity;

  NewPostModel({
    required this.header,
    required this.description,
    required this.tags,
    required this.targetDonation,
    required this.donationFrequency,
    required this.country,
    required this.state,
    required this.city,
    required this.age,
    required this.gender,
    required this.spendingPower,
    required this.validity,
  });
}

// ViewModel handling the form's state and logic.
class NewPostViewModel extends GetxController {
  // Selected tab index for UI.
  final selectedTab = 0.obs;

  // Tags added by user.
  final tags = <String>[].obs;

  // Dropdown selections with default values.
  final donationFrequency = 'One-time'.obs;
  final country = 'India'.obs;
  final state = 'Maharashtra'.obs;
  final city = 'Pune'.obs;
  final age = '21'.obs;
  final gender = 'Male'.obs;
  final spendingPower = '0 to 200 Per month'.obs;

  // Text controllers for input fields.
  late TextEditingController headerController;
  late TextEditingController descriptionController;
  late TextEditingController donationController;
  late TextEditingController validityController;

  // Selected validity date as string.
  final validity = ''.obs;

  // Show date picker and update validity field.
  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (ctx, child) {
        return Theme(
          data: Theme.of(ctx).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFF6B79F5), // header & selected date
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ), dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formatted = DateFormat('dd/MM/yyyy').format(picked);
      validity.value = formatted;
      validityController.text = formatted;
    }
  }

  @override
  void onInit() {
    super.onInit();

    headerController = TextEditingController();
    descriptionController = TextEditingController();
    donationController = TextEditingController();
    validityController = TextEditingController();

    // Sync text controllers to Rx variables.
    headerController.addListener(() => header.value = headerController.text);
    descriptionController.addListener(() => description.value = descriptionController.text);
    donationController.addListener(() => targetDonation.value = donationController.text);
  }

  // Rx strings bound to input fields.
  final header = ''.obs;
  final description = ''.obs;
  final targetDonation = ''.obs;

  // Add/remove tags.
  void toggleTag(String tag) {
    if (tags.contains(tag)) {
      tags.remove(tag);
    } else {
      tags.add(tag);
    }
  }

  // Save post (replace with your real save logic).
  void savePost() {
    final post = NewPostModel(
      header: header.value,
      description: description.value,
      tags: tags.toList(),
      targetDonation: targetDonation.value,
      donationFrequency: donationFrequency.value,
      country: country.value,
      state: state.value,
      city: city.value,
      age: age.value,
      gender: gender.value,
      spendingPower: spendingPower.value,
      validity: validity.value,
    );
    print("Post Saved: ${post.header}");
    // TODO: Implement real save functionality (e.g., API call).
  }
}

// UI for creating a new NGO post.
class NgoNewPost extends StatelessWidget {
  final NewPostViewModel controller = Get.put(NewPostViewModel());

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Post",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            fontSize: 24,
            height: 1.0,
            color: Color(0xFF484848),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(top: 5, left: 2),
          child: Icon(Icons.arrow_back, color: Color(0xFF484848), size: 24),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.01),

              // Top Tab Bar for switching between tabs.
              NgoTabBar(controller: controller),

              if (controller.selectedTab.value == 0)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle("Post Details"),
                        _inputField("Header", controller.headerController),
                        _inputField("Description", controller.descriptionController),
                        _multiServiceInput(controller),
                        _inputField("₹", controller.donationController),
                        _dropdown(
                          "Donation Frequency",
                          controller.donationFrequency,
                          ['One-time', 'Monthly', 'Yearly'],
                        ),
                        SizedBox(height: h * 0.01),
                        _sectionTitle("Audience Profile"),
                        _dropdown(
                          "Country",
                          controller.country,
                          ['India', 'USA', 'UK', 'Canada', 'Australia'],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _dropdown(
                                "State",
                                controller.state,
                                ['Maharashtra', 'Gujarat', 'Rajasthan', 'Punjab', 'Karnataka'],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _dropdown(
                                "City",
                                controller.city,
                                ['Pune', 'Mumbai', 'Ahmedabad', 'Jaipur', 'Bangalore'],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _dropdown(
                                "Age",
                                controller.age,
                                ['18', '21', '25', '30', '35'],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _dropdown(
                                "Gender",
                                controller.gender,
                                ['Male', 'Female', 'Other'],
                              ),
                            ),
                          ],
                        ),
                        _dropdown(
                          "Spending Power",
                          controller.spendingPower,
                          [
                            '0 to 200 Per month',
                            '201 to 500',
                            '501 to 1000',
                            '1001 to 2000',
                            '2001 and above'
                          ],
                        ),

                        // Validity date picker field.
                        _datePickerField("Validity", controller),
                        SizedBox(height: h * 0.05),

                        // Bottom action buttons.
                        NgoBottomWidget(
                          onCancel: () => Get.back(),
                          onContinue: controller.savePost,
                        ),
                        SizedBox(height: h * 0.05),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: Center(
                    child: Text(
                      "Post history will appear here",
                      style: TextStyle(fontSize: w * 0.045, color: Colors.grey),
                    ),
                  ),
                )
            ],
          )),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w700,
          fontSize: 18,
          height: 1.2,
          color: Color(0xFF1F1F1F),
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller) {
    final isRupeeField = label == "₹";

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextField(
        controller: controller,
        keyboardType: isRupeeField ? TextInputType.number : TextInputType.text,
        inputFormatters: isRupeeField ? [FilteringTextInputFormatter.digitsOnly] : null,
        style: const TextStyle(
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF1F1F1F),
        ),
        decoration: InputDecoration(
          labelText: isRupeeField ? "Target Donation" : label,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle: const TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.grey,
          ),
          prefixText: isRupeeField ? '₹ ' : null,
          prefixStyle: const TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          contentPadding: const EdgeInsets.only(bottom: 4),
        ),
      ),
    );
  }

  Widget _dropdown(String label, RxString selected, List<String> items) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF929292),
            ),
          ),
          const SizedBox(height: 1),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selected.value,
                isExpanded: true,
                alignment: Alignment.centerLeft,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
                dropdownColor: Colors.white,
                style: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF1F1F1F),
                ),
                onChanged: (val) {
                  if (val != null) selected.value = val;
                },
                items: items
                    .map((val) => DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                ))
                    .toList(),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _multiServiceInput(NewPostViewModel controller) {
    final TextEditingController tagController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (controller.tags.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  "Tags",
                  style: const TextStyle(
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color(0xFF929292),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          TextField(
            controller: tagController,
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF1F1F1F),
            ),
            decoration: InputDecoration(
              hintText: controller.tags.isEmpty ? "Tags" : null,
              hintStyle: const TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.grey,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2),
              ),
              contentPadding: const EdgeInsets.only(bottom: 2),
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (value) {
              final trimmed = value.trim();
              if (trimmed.isNotEmpty) {
                controller.tags.add(trimmed);
                tagController.clear();
              }
            },
          ),
          const SizedBox(height: 2),
          Obx(() {
            return Wrap(
              spacing: 6,
              runSpacing: 4,
              children: controller.tags
                  .map(
                    (tag) => Chip(
                  label: Text(
                    tag,
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF6B79F5),
                    ),
                  ),
                  backgroundColor: const Color(0x266B79F5),
                  deleteIcon: const Icon(Icons.close, size: 18, color: Colors.black87),
                  onDeleted: () => controller.tags.remove(tag),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0), // reduced vertical padding
                ),
              )
                  .toList(),
            );
          }),
        ],
      ),
    );
  }


  Widget _datePickerField(String label, NewPostViewModel controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Color(0xFF929292),
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () => controller.pickDate(Get.context!),
            child: AbsorbPointer(
              child: TextField(
                controller: controller.validityController,
                style: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF1F1F1F),
                ),
                decoration: const InputDecoration(
                  hintText: "DD/MM/YYYY",
                  hintStyle: TextStyle(
                    color: Color(0xFF929292),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  contentPadding: EdgeInsets.only(bottom: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
