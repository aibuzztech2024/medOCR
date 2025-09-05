import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/viewModels/pharmacy_app/share/my_cart_viewmodel.dart';
import 'package:avatar/views/pharmacy_app/purchase/widgets/Order_CostSummary_Card.dart';
import 'package:avatar/views/pharmacy_app/purchase/widgets/product_card.dart';
import 'package:avatar/views/pharmacy_app/purchase/widgets/select_Payment_method_widget.dart';
import 'package:avatar/views/pharmacy_app/purchase/widgets/select_delivery_address_widget.dart';
import 'package:avatar/views/pharmacy_app/share/widgets/upload_prescription_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCartView extends StatefulWidget {
  const MyCartView({super.key});

  @override
  State<MyCartView> createState() => _MyCartViewState();
}

class _MyCartViewState extends State<MyCartView> {
  late MyCartViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Get.put(MyCartViewModel());
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive spacing
    double screenHeight = Get.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              UploadPrescriptionComponent(title: 'Upload Prescription'),

              // Product Cards List
              Obx(
                () => Column(
                  children:
                      _viewModel.cartProducts.map((product) {
                        return Column(
                          children: [
                            ProductCard(
                              product: product,
                              onBookmarkToggle:
                                  () => _viewModel.toggleBookmark(product),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                          ],
                        );
                      }).toList(),
                ),
              ),

              UploadPrescriptionComponent(title: 'Upload Balance Prescription'),

              SizedBox(height: screenHeight * 0.02),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info, color: Colors.grey.shade600, size: 22),
                  SizedBox(width: 10),
                  AppButton(
                    height: 36,
                    type: ButtonType.filled,
                    onPressed: _viewModel.proceedAnyway,
                    text: 'Proceed Anyway',
                    borderRadius: 8,
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  ),
                ],
              ),

              AddressSelector(),
              SizedBox(height: 12),

              Payment_Method_Selector_widget(),
              SizedBox(height: 12),

              Obx(
                () => OrderCostSummaryCard(
                  onViewPointsHistoryPressed: _viewModel.viewPointsHistory,
                  onViewSummaryPressed: _viewModel.viewOrderSummary,
                  medicineCost: _viewModel.medicineCost,
                  creditPoints: _viewModel.creditPoints.toDouble(),
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<MyCartViewModel>();
    super.dispose();
  }
}
