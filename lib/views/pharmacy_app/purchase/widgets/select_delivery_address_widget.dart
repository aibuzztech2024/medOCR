import 'package:avatar/core/constants/image_paths.dart';
import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/appColors.dart';
import '../../../../viewModels/pharmacy_app/purchase/selectAddress_controller.dart';

class AddressSelector extends StatelessWidget {
  final AddressController controller = Get.put(AddressController());

  Icon getIconForType(AddressType type) {
    switch (type) {
      case AddressType.home:
        return Icon(Icons.home_outlined);
      case AddressType.office:
        return Icon(Icons.business_outlined);
      case AddressType.hostel:
        return Icon(Icons.apartment_outlined);
      case AddressType.other:
      default:
        return Icon(Icons.location_on_outlined);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Select Delivery Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Spacer(),
              IconButton(icon: Icon(Icons.add, size: 28, color: AppColors.pharmacy_PrimaryColor), onPressed: () => showBottomSheet(context)),
            ],
          ),
          ...controller.addresses.map(
            (address) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Container(color: Color.fromRGBO(233, 238, 246, 1), padding: EdgeInsets.all(8), child: getIconForType(address.type)),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(address.label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                        Text(address.fullAddress, style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(child: SvgPicture.asset(AppIcons.edit), onTap: () => showBottomSheet(context, address: address)),
                      SizedBox(width: 8),
                      InkWell(child: SvgPicture.asset(AppIcons.delete), onTap: () => controller.deleteAddress(address.id)),
                      SizedBox(width: 6),

                      Radio<String>(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                        activeColor: LightThemeColors.main_pharmcay,
                        value: address.id,
                        groupValue: controller.selectedAddressId.value,
                        onChanged: (val) => controller.selectAddress(val!),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheet(BuildContext context, {AddressModel? address}) {
    final addressTextController = TextEditingController(text: address?.fullAddress ?? '');
    final type = Rx<AddressType>(address?.type ?? AddressType.home);

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<AddressType>(
              value: type.value,
              items: AddressType.values.map((t) => DropdownMenuItem(value: t, child: Text(t.name.capitalizeFirst!))).toList(),
              onChanged: (val) => type.value = val!,
              decoration: InputDecoration(labelText: 'Address Type'),
            ),
            SizedBox(height: 12),

            TextField(controller: addressTextController, decoration: InputDecoration(labelText: 'Full Address')),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0 ,vertical: 6),
                child: Text(address == null ? 'Add Address' : 'Update Address'),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
