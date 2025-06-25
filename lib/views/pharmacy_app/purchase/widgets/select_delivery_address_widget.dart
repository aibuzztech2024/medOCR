
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/constants/appColors.dart';
import '../../../../viewModels/pharmacy_app/purchase/selectAddress_controller.dart';
class AddressSelector extends StatelessWidget {
  final AddressController controller = Get.put(AddressController());

  Icon getIconForType(AddressType type) {
    switch (type) {
      case AddressType.home:
        return Icon(Icons.home, color: Colors.blue);
      case AddressType.office:
        return Icon(Icons.business, color: Colors.blue);
      case AddressType.hostel:
        return Icon(Icons.apartment, color: Colors.blue);
      case AddressType.other:
      default:
        return Icon(Icons.location_on, color: Colors.blue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Select Delivery Address',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Spacer(),
            IconButton(
              icon: Icon(Icons.add, color: AppColors.pharmacy_PrimaryColor),
              onPressed: () => showBottomSheet(context),
            ),
          ],
        ),
        ...controller.addresses.map((address) => Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: getIconForType(address.type),
            title: Text(address.label),
            subtitle: Text(address.fullAddress),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => showBottomSheet(context, address: address),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => controller.deleteAddress(address.id),
                ),
                Radio<String>(
                  activeColor: Colors.blue,
                  value: address.id,
                  groupValue: controller.selectedAddressId.value,
                  onChanged: (val) => controller.selectAddress(val!),
                ),
              ],
            ),
          ),
        )),
      ],
    ));
  }

  void showBottomSheet(BuildContext context, {AddressModel? address}) {
    final addressTextController = TextEditingController(text: address?.fullAddress ?? '');
    final type = Rx<AddressType>(address?.type ?? AddressType.home);

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<AddressType>(
              value: type.value,
              items: AddressType.values
                  .map((t) => DropdownMenuItem(
                value: t,
                child: Text(t.name.capitalizeFirst!),
              ))
                  .toList(),
              onChanged: (val) => type.value = val!,
              decoration: InputDecoration(labelText: 'Address Type'),
            ),
            SizedBox(height: 12),

            TextField(
              controller: addressTextController,
              decoration: InputDecoration(labelText: 'Full Address'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                final newAddr = AddressModel(
                  id: address?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                  type: type.value,
                  fullAddress: addressTextController.text.trim(),
                );

                if (address == null) {
                  controller.addAddress(newAddr);
                } else {
                  controller.updateAddress(address.id, newAddr);
                }

                Get.back();
              },
              child: Text(address == null ? 'Add Address' : 'Update Address'),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
