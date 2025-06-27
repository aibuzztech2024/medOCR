import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/appColors.dart';
import '../../../../viewModels/pharmacy_app/purchase/selectPaymentMethod_controller.dart';

class Payment_Method_Selector_widget extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Select Payment Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Spacer(),
            IconButton(icon: Icon(Icons.add, size:24,color: AppColors.pharmacy_PrimaryColor), onPressed: () {}),
          ],
        ),

        // Payment options
        Obx(
          () => Column(
            children: [
              Row(
                children: [
                  Text('UPI', style: TextStyle( fontWeight: FontWeight.bold)),
                  Spacer(),
                  Radio<PaymentMethod>(
                    value: PaymentMethod.upi,
                    groupValue: controller.selectedMethod.value,
                    onChanged: (value) {
                      controller.selectMethod(value!);
                    },
                    activeColor: Colors.teal,
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Credit or Debit Card', style: TextStyle(fontWeight: FontWeight.w600)),
                  Spacer(),
                  Radio<PaymentMethod>(
                    value: PaymentMethod.card,
                    groupValue: controller.selectedMethod.value,
                    onChanged: (value) {
                      controller.selectMethod(value!);
                    },
                    activeColor: Colors.teal,
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Cash On Delivery', style: TextStyle(fontWeight: FontWeight.w600)),
                  Spacer(),
                  Radio<PaymentMethod>(
                    value: PaymentMethod.cod,
                    groupValue: controller.selectedMethod.value,
                    onChanged: (value) {
                      controller.selectMethod(value!);
                    },
                    activeColor: Colors.teal,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
