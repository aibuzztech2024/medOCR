import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../models/donate/campaign_model.dart';
import '../../../viewModels/donate/donate_checkout_view_model.dart';
import '../../../viewModels/donate/campaign_view_model.dart';
import '../widgets/campaign_card_view.dart';
import 'package:file_picker/file_picker.dart';

class DonateCheckoutPage extends StatefulWidget {
  final CampaignModel? campaign; // Optional campaign to donate to
  const DonateCheckoutPage({Key? key, this.campaign}) : super(key: key);

  @override
  State<DonateCheckoutPage> createState() => _DonateCheckoutPageState();
}

class _DonateCheckoutPageState extends State<DonateCheckoutPage> {
  final DonateCheckoutViewModel vm = Get.put(DonateCheckoutViewModel()); // Donation logic & state
  final CampaignViewModel campaignVm = Get.find<CampaignViewModel>(); // Campaign state from elsewhere

  @override
  void initState() {
    super.initState();
    // Get the campaign passed or from the campaign view model
    final campaign = widget.campaign ?? campaignVm.campaign.value;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    final screenHeight = Get.height;
    final campaign = widget.campaign ?? campaignVm.campaign.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Donate"),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(), // Navigate back on press
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05), // Screen padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CampaignCardView(campaign: campaign), // Show campaign summary card
            SizedBox(height: screenHeight * 0.01),

            Center(
              child: Text(
                "Enter Amount",
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),

          Obx(() {
            final text = vm.inputText.value.isEmpty ? '0' : vm.inputText.value;

            return Center(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(vm.amountFocusNode);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Visible formatted text
                    Text(
                      '₹$text',
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    // Invisible TextField for input
                    SizedBox(
                      width: screenWidth * 0.6,
                      child: EditableText(
                        controller: vm.amountController,
                        focusNode: vm.amountFocusNode,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        style: const TextStyle(
                          color: Colors.transparent, // Hide typed text
                          fontSize: 0.1, // Prevent layout shift
                        ),
                        cursorColor: Colors.orange,
                        backgroundCursorColor: Colors.orange,
                        textAlign: TextAlign.center, // Keep the blinking cursor centered
                        onChanged: (value) {
                          vm.updateAmount(int.tryParse(value) ?? 0);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),



          SizedBox(height: 6),

            Center(
              child: Text(
                "Min: ₹100\n(Platform Fee: 2%)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.025),

            Text(
              "Select Payment Method",
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),

            Obx(() => Column(
              children: [
                _buildPaymentTile("UPI Payment", 'assets/icons/upi.svg', 1), // Payment option 1
                SizedBox(height: 10),
                _buildPaymentTile("Credit or Debit Card", 'assets/icons/credit_card.svg', 2), // Payment option 2
              ],
            )),
            SizedBox(height: screenHeight * 0.03),

            Text(
              "Enter PAN Number & Document",
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    onChanged: vm.updatePan, // Update PAN number in ViewModel
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.black, // Text color (you can change if needed)
                    ),
                    decoration: InputDecoration(
                      hintText: "PAN Number",
                      hintStyle: TextStyle(
                        color: Colors.grey, // Grey color for hint text
                      ),
                      fillColor: Colors.grey.shade200, // Light grey background color
                      filled: true, // Enable background fill
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey, // Grey border color
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey, // Grey border when enabled but not focused
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey, // Grey border when focused
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: Obx(() => ElevatedButton(
                    onPressed: () async {
                      // Pick file for PAN document
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
                      );
                      if (result != null) {
                        vm.updatePanDocument(File(result.files.single.path!)); // Update doc in VM
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: vm.panDocument.value == null ? Colors.grey.shade200 : Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/upload.svg',
                      height: Get.width * 0.05,
                      color: vm.panDocument.value == null ? Colors.grey : Colors.white,
                    ),
                  )),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.04),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBottomButton("Cancel", onPressed: () => Get.back()), // Cancel button
                Obx(() => _buildBottomButton(
                  "Pay",
                  isPrimary: true,
                  enabled: vm.isFormValid, // Enable only if form valid
                  onPressed: vm.isFormValid ? vm.submitDonation : null, // Submit donation on press
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build a payment method option tile
  Widget _buildPaymentTile(String title, String icon, int method) {
    final selected = vm.selectedPaymentMethod.value == method; // Check if selected
    return GestureDetector(
      onTap: () => vm.selectPaymentMethod(method), // Select payment method on tap
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Colors.orange : Colors.grey.shade300,
            width: 1.5,
          ),
          color: selected ? Colors.orange.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon, height: 24), // Payment icon
            const SizedBox(width: 12),
            Text(title, style: TextStyle(fontSize: Get.width * 0.04)), // Payment method title
            const Spacer(),
            Container(
              width: Get.width * 0.05,
              height: Get.width * 0.05,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? Colors.orange : Colors.grey,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                child: Container(
                  width: Get.width * 0.025,
                  height: Get.width * 0.025,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                ),
              )
                  : null, // Inner dot if selected
            ),
          ],
        ),
      ),
    );
  }

  // Widget for bottom action buttons (Cancel, Pay)
  Widget _buildBottomButton(String label, {
    VoidCallback? onPressed,
    bool isPrimary = false,
    bool enabled = true,
  }) {
    return SizedBox(
      width: Get.width * 0.42,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null, // Enable/disable button
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary
              ? (enabled ? Colors.orange : Colors.grey.shade400) // Primary button color
              : Colors.orange, // Secondary button color
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.012),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: TextStyle(fontSize: Get.width * 0.035)),
            if (isPrimary) ...[
              SizedBox(width: 6),
              Icon(Icons.arrow_forward, size: Get.width * 0.04), // Arrow icon for primary button
            ],
          ],
        ),
      ),
    );
  }
}
