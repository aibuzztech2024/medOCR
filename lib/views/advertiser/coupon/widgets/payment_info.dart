import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// ViewModel using GetX
class PaymentViewModel extends GetxController {
  final amount = 0.0.obs;
  final inputText = ''.obs;
  final redemptions = 660.obs;
  final selectedDate = ''.obs;
  final selectedPayment = ''.obs;
  final creditUsed = 0.obs;

  final totalCredit = 3245;

  final amountController = TextEditingController(); // For TextField
  final editableAmountController = TextEditingController(); // For center EditableText
  final amountFocusNode = FocusNode();

  final platformFeePercent = 2.0;
  final gstPercent = 18.0;

  void updateText(String text) {
    inputText.value = text;
    amount.value = double.tryParse(text) ?? 0;
  }

  void updateCreditUsed(String value) {
    creditUsed.value = int.tryParse(value) ?? 0;
  }

  double get platformFee => (amount.value * platformFeePercent) / 100;
  double get gstFee => (platformFee * gstPercent) / 100;
  double get subtotal => amount.value + platformFee + gstFee;
  double get total => subtotal - creditUsed.value;
  int get revisedCredit => totalCredit - creditUsed.value;

  void selectPayment(String method) => selectedPayment.value = method;

  void pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.white, // white background
            colorScheme: ColorScheme.light(
              primary: Colors.redAccent, // header and active dates
              onPrimary: Colors.white,    // text on header
              onSurface: Colors.black,    // text color
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate.value = DateFormat('dd/MM/yy').format(picked);
    }
  }

}


/// PaymentPage content widget WITHOUT scaffold
class PaymentInfo extends StatelessWidget {
  final controller = Get.put(PaymentViewModel());

  @override
  Widget build(BuildContext context) {
    double w = Get.width;
    double h = Get.height;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: w * 0.01),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: h * 0.001),

          /// Title
          Center(
            child: Text(
              "Pay Amount",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600, // 600 weight (SemiBold)
                fontSize: 20, // as per your design
                color: Color(0xFF484848), // dark grey
                height: 1.2, // line-height = 120%
                letterSpacing: 0,
              ),
            ),
          ),


          SizedBox(height: h * 0.010),

          /// Editable Overlay Amount
          /// Editable Overlay Amount
          Center(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(controller.amountFocusNode),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Obx(() => Text(
                    "₹${controller.inputText.value.isEmpty ? '0' : controller.inputText.value}",
                    style: TextStyle(fontSize: w * 0.08, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    width: w * 0.5,
                    child: EditableText(
                      controller: controller.editableAmountController,
                      focusNode: controller.amountFocusNode,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(color: Colors.transparent, fontSize: 0.01),
                      cursorColor: Colors.transparent,
                      backgroundCursorColor: Colors.transparent,
                      textAlign: TextAlign.center,
                      onChanged: controller.updateText,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 2),
          Center(
            child: Text(
              "Min: ₹100\nPlatform Fee 2%",
              style: TextStyle(fontSize: w * 0.034, color: Colors.grey.shade800),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: h * 0.025),

          TextField(
            controller: controller.amountController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (val) {
              // Optional: handle independently
            },
            decoration: InputDecoration(
              hintText: "Enter Amount for Coupon Post",
              hintStyle: TextStyle(color: Colors.black54), // <== This sets hint text color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.black87),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.black87),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.black87, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),

          ),

          SizedBox(height: h * 0.03),

          /// Max Redemptions Dropdown
          Text("Maximum Redemptions *", style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 6),
          DropdownButtonFormField<int>(
            value: controller.redemptions.value,
            items: [660, 500, 300]
                .map((e) => DropdownMenuItem(
              value: e,
              child: Text(
                "$e",
                style: TextStyle(color: Colors.black87), // dropdown item color
              ),
            ))
                .toList(),
            onChanged: (val) => controller.redemptions.value = val ?? 660,
            decoration: InputDecoration(
              hintText: "Select Redemption",
              hintStyle: TextStyle(color: Colors.black87), // hint text color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.black87),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.black87),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.black87, width: 1),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
            dropdownColor: Colors.white, // dropdown background
            icon: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black87),
          ),
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: Text("1 rupee per redemption", style: TextStyle(fontSize: w * 0.032)),
          ),


          /// Validity
          SizedBox(height: h * 0.03),
          Text("Validity *", style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 6),
          GestureDetector(
            onTap: () => controller.pickDate(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade900),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Text(controller.selectedDate.value.isEmpty ? "DD/MM/YY" : controller.selectedDate.value),
                  Spacer(),
                  SvgPicture.asset(
                    'assets/icons/calendar.svg',
                    height: 22,
                    width: 22,
                  )
                ],
              ),
            ),
          ),

          /// Payment Selection
          SizedBox(height: h * 0.03),
          Text("Select Account or card for recharge", style: TextStyle(fontWeight: FontWeight.w600),),
          SizedBox(height: h * 0.015),
          Text("UPI", style: TextStyle(fontWeight: FontWeight.w400)),

          SizedBox(height: h * 0.010),
          /// UPI

          paymentTile('UPI', 'assets/icons/upi.svg',),
          SizedBox(height: 12),

          /// More Options
          Text("MORE WAYS TO PAY", style: TextStyle(fontWeight: FontWeight.w400)),
          SizedBox(height: 6),

          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0x4DFF6F61)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // Top tile (no border radius)
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  child: paymentTile('Net Banking', null),
                ),

                // Bottom tile (no border radius)
                ClipRRect(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(2)),
                  child: paymentTile('Cash on delivery/Pay on delivery', null),
                ),
              ],
            ),
          ),



          /// Fee Summary
          SizedBox(height: h * 0.03),
          buildFeeRow("Service Fee", controller.amount.value),
          buildFeeRow("GST Fee", controller.gstFee),
          buildFeeRow("Subtotal", controller.subtotal),

          /// Credit Row
          SizedBox(height: h * 0.025),
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: w * 0.04, color: Colors.black),
                    children: [
                      TextSpan(text: "Total Credit balance: ", style: TextStyle(fontWeight: FontWeight.w400, color: Color(0xFF626262))),
                      TextSpan(text: "${controller.totalCredit}", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade700),),
                      TextSpan(text: "   Revised credit balance: ", style: TextStyle(fontWeight: FontWeight.w400,color: Color(0xFF626262))),
                      TextSpan(text: "${controller.revisedCredit}", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: w * 0.02),
              SizedBox(
                width: w * 0.2,
                height: w * 0.1,
                child: TextField(
                  onChanged: controller.updateCreditUsed,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: Color(0xFFFF6F61)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: Color(0xFFFF6F61)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: Color(0xFFFF6F61), width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// Total
          SizedBox(height: h * 0.03),
          buildFeeRow("Total", controller.total, isBold: true),

          /// Buttons
          SizedBox(height: h * 0.03),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.grey.shade900,  // Make text color consistent and visible
                      fontWeight: FontWeight.w600,   // Match font weight with Post button text
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.grey.shade800),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),  // Match border radius if needed
                    ),
                  ),
                ),
              ),

              SizedBox(width: w * 0.06),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Post",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6F61),
                  padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

            ],
          ),

          SizedBox(height: h * 0.03),
        ],
      )),
    );
  }

  /// Widget for Payment Option Tile
  Widget paymentTile(String title, String? svgPath) {
    final controller = Get.find<PaymentViewModel>();
    return Obx(() => GestureDetector(
      onTap: () => controller.selectPayment(title),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color: controller.selectedPayment.value == title
                ? Color(0xFFFF6F61) : Color(0x4DFF6F61)
            ,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              controller.selectedPayment.value == title
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: controller.selectedPayment.value == title
                  ? Color(0xFFFF6F61) : Colors.grey,
            ),
            SizedBox(width: 12),
            Text(title, style: TextStyle(fontSize: Get.width * 0.04)),
            Spacer(),
            if (svgPath != null)
              SvgPicture.asset(
                svgPath,
                height: 20,
                width: 43,
              ),
          ],
        ),
      ),
    ));
  }

  /// Widget for Fee Row
  Widget buildFeeRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
        Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w400, // 400 weight
          fontStyle: FontStyle.normal,
          fontSize: 14,
          height: 1.2, // line-height = 120%
          letterSpacing: 0,
          color: Color(0xFF626262),
        ),
      ),
          Spacer(),
        Text(
          "₹${value.toStringAsFixed(0)}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w600, // SemiBold = 600
            fontSize: 16,
            height: 1.2, // line-height = 120%
            letterSpacing: 0,
            color: Color(0xFF484848),
          ),
        ),
        ],
      ),
    );
  }
}
