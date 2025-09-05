import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Model
class MedicineModel {
  RxString name;
  RxInt quantity;
  RxDouble cost;
  RxString manufacturer;
  RxString saltComposition;
  RxString packagingType;
  RxBool isSelected;
  RxBool isExpanded;

  MedicineModel({
    required String name,
    required int quantity,
    required double cost,
    required String manufacturer,
    required String saltComposition,
    required String packagingType,
    bool selected = false,
    bool expanded = false,
  })  : name = name.obs,
        quantity = quantity.obs,
        cost = cost.obs,
        manufacturer = manufacturer.obs,
        saltComposition = saltComposition.obs,
        packagingType = packagingType.obs,
        isSelected = selected.obs,
        isExpanded = expanded.obs;
}

/// ViewModel
class MedicineViewModel extends GetxController {
  var medicineList = <MedicineModel>[
    MedicineModel(
      name: "Sinopril",
      quantity: 2,
      cost: 100,
      manufacturer: "Cipla",
      saltComposition: "Paracetamol (650mg),\nCaffeine (50mg)",
      packagingType: "Bottle",
    ),
    MedicineModel(
      name: "Morvastatin",
      quantity: 2,
      cost: 280,
      manufacturer: "Sun Pharma",
      saltComposition: "Atorvastatin (10mg)",
      packagingType: "Strip",
    ),
  ].obs;

  void toggleExpanded(int index) {
    medicineList[index].isExpanded.toggle();
  }

  void toggleSelection(int index) {
    medicineList[index].isSelected.toggle();
  }
}

/// Medicine list widget without Scaffold, can be embedded anywhere
class MedicineListWidget extends StatelessWidget {
  final MedicineViewModel controller = Get.put(MedicineViewModel());

  MedicineListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        physics: const NeverScrollableScrollPhysics(), // disable scroll to avoid conflicts
        shrinkWrap: true, // wrap height to content size
        padding: const EdgeInsets.symmetric(horizontal: 5),
        children: [

          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Uploaded Medicines', // Replace with your desired title
                  style: const TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF484848),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),

              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: const Text(
                  "See all",
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3AAFA9),
                  ),
                ),
              ),
            ],
          ),



          const SizedBox(height: 12),

          /// Cards
          ...List.generate(
            controller.medicineList.length,
                (index) => medicineCard(controller.medicineList[index], index),
          ),

          const SizedBox(height: 20),

          /// Add to Cart Button
          Center(
            child: SizedBox(
              width: 100,
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3AAFA9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: const Center(
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      );
    });
  }

  /// Medicine Card
  Widget medicineCard(MedicineModel item, int index) {
    final controller = Get.find<MedicineViewModel>();

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Checkbox & Name
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Material(
                color: Colors.transparent,
                child: Checkbox(
                  value: item.isSelected.value,
                  onChanged: (_) => controller.toggleSelection(index),
                  activeColor: Colors.teal,
                ),
              )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText("Product Name"),
                    Obx(() => underlineText(item.name.value)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          /// Quantity & Cost
          Row(
            children: [
              /// Quantity
              Expanded(
                child: infoInputColumn(
                  "Quantity",
                  item.quantity.value.toString(),
                      (val) => item.quantity.value = int.tryParse(val) ?? 0,
                  paddingLeft: 52,
                ),
              ),
              const SizedBox(width: 52),

              /// Cost
              Expanded(
                child: Container(
                  height: 65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      labelText("Cost"),
                      const SizedBox(height: 6),
                      TextField(
                        controller: TextEditingController(text: "₹${item.cost.value.toInt()}"),
                        enabled: false,
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.only(bottom: 6),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF3AAFA9), width: 1),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF3AAFA9), width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// More / Less toggle
          GestureDetector(
            onTap: () => controller.toggleExpanded(index),
            child: Padding(
              padding: const EdgeInsets.only(left: 52),
              child: Obx(() {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.isExpanded.value ? "Less" : "More",
                      style: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF1F1F1F),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      item.isExpanded.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.teal,
                      size: 20,
                    )
                  ],
                );
              }),
            ),
          ),

          const SizedBox(height: 16),

          /// Expanded Fields
          Obx(() {
            if (!item.isExpanded.value) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(left: 52, top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  editableInfoRow("Manufacturer", item.manufacturer),
                  const SizedBox(height: 12),
                  editableInfoRow("Salt Composition", item.saltComposition, isMultiline: true),
                  const SizedBox(height: 12),
                  editableInfoRow("Packaging Type", item.packagingType),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Label Text
  Widget labelText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Open Sans',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF929292),
      ),
    );
  }

  /// Underlined Text with bottom border
  Widget underlineText(String value) {
    return Container(
      padding: const EdgeInsets.only(bottom: 6),
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF3AAFA9), width: 1)),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontFamily: 'Open Sans',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  /// Quantity Input Field
  Widget infoInputColumn(String label, String value, Function(String)? onChanged,
      {bool isEnabled = true, double paddingLeft = 0}) {
    return Container(
      height: 65,
      padding: EdgeInsets.only(left: paddingLeft),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          labelText(label),
          const SizedBox(height: 6),
          TextField(
            controller: TextEditingController(text: value),
            onChanged: onChanged,
            enabled: isEnabled,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(bottom: 6),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF3AAFA9)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF3AAFA9), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Editable fields in expanded area
  Widget editableInfoRow(String label, RxString value, {bool isMultiline = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText(label),
        const SizedBox(height: 4),
        Obx(() {
          return TextField(
            controller: TextEditingController(text: value.value),
            onChanged: (val) => value.value = val,
            maxLines: isMultiline ? null : 1,
            keyboardType: isMultiline ? TextInputType.multiline : TextInputType.text,
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(bottom: 6),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF3AAFA9)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF3AAFA9), width: 2),
              ),
            ),
          );
        }),
      ],
    );
  }
}
