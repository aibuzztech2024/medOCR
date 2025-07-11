import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPostModel {
  List<String> ngo_services;

  String ngo_name;
  String country;
  String state;
  String city;

  String address;
  String pincode;

  NewPostModel({
    required this.ngo_name,
    required this.ngo_services,

    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.pincode,
  });
}

class organizerDetails_controller extends GetxController {
  final selectedTab = 0.obs;
  final tags = <String>[].obs;

  final country = 'India'.obs;
  final state = 'Maharashtra'.obs;
  final city = 'Pune'.obs;

  late TextEditingController ngo_name_Controller;

  late TextEditingController validityController;
  late TextEditingController addressController;
  late TextEditingController pincodeController;

  final ngo_name = 'Smile foundation'.obs;

  final address = 'jhajjar ,haryana'.obs;
  final pincode = '124103'.obs;

  @override
  void onInit() {
    super.onInit();

    ngo_name_Controller = TextEditingController(text: ngo_name.value);
    addressController = TextEditingController(text: address.value);
    pincodeController = TextEditingController(text: pincode.value);
    validityController = TextEditingController(); // can be empty if not set

    // Listener to sync data
    ngo_name_Controller.addListener(() => ngo_name.value = ngo_name_Controller.text);
    addressController.addListener(() => address.value = addressController.text);
    pincodeController.addListener(() => pincode.value = pincodeController.text);
  }


  void toggleTag(String tag) {
    if (tags.contains(tag)) {
      tags.remove(tag);
    } else {
      tags.add(tag);
    }
  }

  void savePost() {
    final post = NewPostModel(
      ngo_name: ngo_name.value,
      ngo_services: tags.toList(),

      country: country.value,
      state: state.value,
      city: city.value,

      address: address.value,
      pincode: pincode.value,
    );
    print("Post Saved: ${post.ngo_name}");
  }
}

class OrganizerDetailsView extends StatelessWidget {
  final controller = Get.put(organizerDetails_controller());

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Organization Details"),
                      _inputField("NGO Name", controller.ngo_name_Controller),
                      _multiServiceInput(controller),
                      _dropdown("Country", controller.country, ['India', 'USA', 'UK', 'Canada', 'Australia']),
                      Row(
                        children: [
                          Expanded(child: _dropdown("State", controller.state, ['Maharashtra', 'Gujarat', 'Rajasthan', 'Punjab', 'Karnataka'])),
                          SizedBox(width: 10),
                          Expanded(child: _dropdown("City", controller.city, ['Pune', 'Mumbai', 'Ahmedabad', 'Jaipur', 'Bangalore'])),
                        ],
                      ),
                      _inputField("Address", controller.addressController),
                      _inputField("Pincode", controller.pincodeController),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18, height: 1.2, color: Color(0xFF1F1F1F))),
    );
  }

  Widget _inputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF929292))),
          TextField(
            controller: controller,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF1F1F1F)),
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
              contentPadding: EdgeInsets.only(bottom: 4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdown(String label, RxString selected, List<String> items) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF929292))),
          const SizedBox(height: 1),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selected.value,
                isExpanded: true,
                alignment: Alignment.centerLeft,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
                dropdownColor: Colors.white,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF1F1F1F)),
                onChanged: (val) {
                  if (val != null) selected.value = val;
                },
                items: items.map((val) => DropdownMenuItem<String>(value: val, child: Text(val))).toList(),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _multiServiceInput(organizerDetails_controller controller) {
    final TextEditingController tagController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("NGO Services", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF929292))),
          const SizedBox(height: 4),
          TextField(
            controller: tagController,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF1F1F1F)),
            decoration: InputDecoration(
              hintText: controller.tags.isEmpty ? "Add more services........" : null,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
              contentPadding: const EdgeInsets.only(bottom: 2),
            ),
            onSubmitted: (value) {
              final trimmed = value.trim();
              if (trimmed.isNotEmpty) {
                controller.tags.add(trimmed);
                tagController.clear();
              }
            },
          ),
          const SizedBox(height: 6),
          Obx(() {
            return Wrap(
              spacing: 6,
              runSpacing: 4,
              children:
                  controller.tags
                      .map(
                        (tag) => Chip(
                          label: Text(tag, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF6B79F5))),
                          backgroundColor: const Color(0x266B79F5),
                          deleteIcon: const Icon(Icons.close, size: 18, color: Colors.black87),
                          onDeleted: () => controller.tags.remove(tag),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        ),
                      )
                      .toList(),
            );
          }),
        ],
      ),
    );
  }
}
