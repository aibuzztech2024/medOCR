// views/order_payment_view.dart
import 'package:avatar/views/order_payment/order_payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar/views/order_payment/widgets/cash_on_delivery_component.dart';
import 'package:avatar/views/order_payment/widgets/other_options_component.dart';
import 'package:avatar/views/order_payment/widgets/payment_summary.dart';
import 'package:avatar/views/order_payment/widgets/upi_payment_component.dart';

class OrderPaymentView extends StatelessWidget {
  const OrderPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller - GetX handles dependency injection
    final controller = Get.put(OrderPaymentController());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Order Payment'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const _OrderPaymentBody(),
    );
  }
}

class _OrderPaymentBody extends StatelessWidget {
  const _OrderPaymentBody();

  @override
  Widget build(BuildContext context) {
    // Get controller instance
    final controller = Get.find<OrderPaymentController>();
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive design values
    final horizontalPadding = screenWidth > 600 ? 32.0 : 16.0;
    final verticalSpacing = screenWidth > 600 ? 24.0 : 20.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 16.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Payment summary section
            PaymentSummary(
              title: 'Payment Summary',
              items: controller.paymentItems,
              totalItem: controller.totalItem,
            ),

            SizedBox(height: verticalSpacing),

            // UPI payment options section
            UpiPaymentComponent(
              paymentOptions: controller.upiPaymentOptions,
              onAddNewUpiTap: controller.handleAddNewUpiTap,
            ),

            SizedBox(height: verticalSpacing),

            // Cash on delivery option with reactive state
            Obx(
              () => PaymentOptionComponent(
                iconAsset: 'assets/icons/cash_on_delivery.svg',
                title: 'Cash on Delivery',
                subtitle: 'Pay at the time of delivery',
                isSelected: controller.isCashOnDeliverySelected,
                onTap: controller.handleCashOnDeliveryTap,
                backgroundColor: Colors.white,
                borderColor: Colors.grey,
                borderRadius: 12,
              ),
            ),

            SizedBox(height: verticalSpacing),

            // Other payment options section
            OtherOptionsComponent(
              title: 'Other Options',
              options: controller.otherOptions,
            ),

            // Bottom spacing for better scroll experience
            SizedBox(height: verticalSpacing),
          ],
        ),
      ),
    );
  }
}
