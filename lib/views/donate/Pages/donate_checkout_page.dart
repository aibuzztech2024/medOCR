import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../models/donate/campaign_model.dart';
import '../../../viewModels/donate/donate_checkout_view_model.dart';
import '../../../viewModels/donate/campaign_view_model.dart';
import '../widgets/donate_campaign_card.dart';
import 'package:file_picker/file_picker.dart';
import 'donation_failed.dart';

class DonateCheckoutPage extends StatefulWidget {
  final CampaignModel? campaign;
  const DonateCheckoutPage({Key? key, this.campaign}) : super(key: key);

  @override
  State<DonateCheckoutPage> createState() => _DonateCheckoutPageState();
}

class _DonateCheckoutPageState extends State<DonateCheckoutPage> {
  final DonateCheckoutViewModel vm = Get.put(DonateCheckoutViewModel());
  final CampaignViewModel campaignVm = Get.find<CampaignViewModel>();

  @override
  void initState() {
    super.initState();
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
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DonateCampaignCard(campaign: campaign, showBookmark: false),
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
                      Text(
                        '₹$text',
                        style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFF6F61),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.6,
                        child: EditableText(
                          controller: vm.amountController,
                          focusNode: vm.amountFocusNode,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          style: const TextStyle(
                            color: Colors.transparent,
                            fontSize: 0.1,
                          ),
                          cursorColor: Colors.transparent,
                          backgroundCursorColor: Colors.transparent,
                          textAlign: TextAlign.center,
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
                _buildPaymentTile("UPI Payment", 'assets/icons/upi.svg', 1),
                SizedBox(height: 10),
                _buildPaymentTile("Credit or Debit Card", 'assets/icons/credit_card.svg', 2),
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
                    onChanged: vm.updatePan,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "PAN Number",
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
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
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
                      );
                      if (result != null) {
                        vm.updatePanDocument(File(result.files.single.path!));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: vm.panDocument.value == null
                          ? Colors.grey.shade200
                          : const Color(0xFFFF6F61),
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
                _buildBottomButton("Cancel", onPressed: () => Get.back()),
                Obx(() => _buildBottomButton(
                  "Pay",
                  isPrimary: true,
                  enabled: vm.isFormValid,
                  onPressed: vm.isFormValid ? _showConfirmBottomSheet : null,
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentTile(String title, String icon, int method) {
    final selected = vm.selectedPaymentMethod.value == method;
    return GestureDetector(
      onTap: () => vm.selectPaymentMethod(method),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? const Color(0xFFFF6F61) : Colors.black87,
            width: 1.5,
          ),
          color: selected ? const Color(0xFFFF6F61).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon, height: 24),
            const SizedBox(width: 12),
            Text(title, style: TextStyle(fontSize: Get.width * 0.04)),
            const Spacer(),
            Container(
              width: Get.width * 0.05,
              height: Get.width * 0.05,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? const Color(0xFFFF6F61) : Colors.black87,
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
                    color: Color(0xFFFF6F61),
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(
      String label, {
        VoidCallback? onPressed,
        bool isPrimary = false,
        bool enabled = true,
      }) {
    return SizedBox(
      width: Get.width * 0.20,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary
              ? (enabled ? const Color(0xFFFF6F61) : const Color(0xFFFFF8E9))
              : const Color(0xFFFFEDED),

            foregroundColor: isPrimary
              ? (enabled ? Colors.white : Colors.black54)
              : Colors.black54,
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.012),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: Get.width * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isPrimary) ...[
              const SizedBox(width: 6),
              Icon(
                Icons.arrow_forward,
                size: Get.width * 0.04,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showConfirmBottomSheet() {
    final int amount = int.tryParse(vm.inputText.value) ?? 0;
    final double platformFee = amount * 0.02;
    final double gst = platformFee * 0.18;
    final double toNgo = amount - platformFee - gst;

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBreakdownRow("Amount to NGO", toNgo),
              _buildBreakdownRow("Platform Fee (2%)", platformFee),
              _buildBreakdownRow("GST on Platform Fee (18%)", gst),
              const SizedBox(height: 16),
              _buildBreakdownRow("Total Amount Donor Pays", amount.toDouble(), isTotal: true),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBottomButton("Cancel", onPressed: () => Get.back()),
                  _buildBottomButton(
                    "Pay",
                    isPrimary: true,
                    onPressed: () {
                      Get.back(); // Close bottom sheet

                      // Show loader overlay
                      Get.generalDialog(
                        barrierDismissible: false,
                        barrierColor: Colors.transparent,
                        transitionDuration: Duration.zero,
                        pageBuilder: (_, __, ___) => const DonationFailed(),
                      );

                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBreakdownRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: Get.width * 0.038,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey.shade700,
            ),
          ),
          Text(
            "₹${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: Get.width * 0.04,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
