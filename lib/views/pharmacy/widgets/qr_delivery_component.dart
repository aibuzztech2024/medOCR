import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Model: Holds OTP and QR data.
class DeliveryModel {
  final String otp;
  final String qrData;

  DeliveryModel({required this.otp, required this.qrData});
}

/// Controller: Manages OTP, scanned code, and confirmation state.
class DeliveryController extends GetxController {
  final deliveryData = DeliveryModel(otp: '4653', qrData: '4653').obs;
  final scannedCode = ''.obs;
  final isConfirmed = false.obs;

  void onQRScanned(String code) {
    scannedCode.value = code;
    if (code == deliveryData.value.otp) {
      isConfirmed.value = true;
      Get.snackbar("Success", "Delivery Confirmed!", snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Error", "Invalid OTP", snackPosition: SnackPosition.BOTTOM);
    }
  }

  void verifyOtp(String inputOtp) {
    if (inputOtp == deliveryData.value.otp) {
      isConfirmed.value = true;
      Get.snackbar("Success", "Delivery Confirmed!", snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Error", "Incorrect OTP", snackPosition: SnackPosition.BOTTOM);
    }
  }
}

/// QR Delivery Component (Without Scaffold)
class QRDeliveryComponent extends StatelessWidget {
  final DeliveryController controller = Get.put(DeliveryController());
  final TextEditingController otpController = TextEditingController();

  QRDeliveryComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Get.width;
    final double screenHeight = Get.height;

    final double qrSize = screenWidth * 0.5;
    final double paddingHorizontal = screenWidth * 0.06;
    final double spacingLarge = screenHeight * 0.05;
    final double spacingMedium = screenHeight * 0.025;
    final double spacingSmall = screenHeight * 0.015;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: spacingLarge),

          /// Instruction header
          Text(
            "Scan the QR or give OTP to confirm delivery",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w400,
              height: 1.2,
              letterSpacing: 0,
              color: Colors.black87,
              fontFamily: 'OpenSans',
            ),
          ),

          SizedBox(height: spacingMedium),

          /// Dummy QR Image
          Container(
            width: qrSize,
            height: qrSize,
            padding: EdgeInsets.all(qrSize * 0.05),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/qr.png',
                  fit: BoxFit.contain,
                  height: qrSize,
                  width: qrSize,
                ),
                Text(
                  "Scan QR for delivery",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w700,
                    fontSize: screenWidth * 0.045,
                    height: 1.2,
                    letterSpacing: 0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spacingMedium),

          /// OTP Display
          Obx(() => RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: controller.deliveryData.value.otp,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700,
                fontSize: screenWidth * 0.07,
                height: 1.2,
                letterSpacing: 0,
                color: const Color(0xFF484848),
              ),
              children: [
                TextSpan(
                  text: " OTP",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth * 0.06,
                    height: 1.2,
                    letterSpacing: 0,
                    color: const Color(0xFF484848),
                  ),
                ),
              ],
            ),
          )),

          SizedBox(height: spacingSmall),

          /// Warning Text
          Text(
            "Do not give OTP over the phone.\nOnly scan the QR or give OTP after the delivery is received at your given address.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w400,
              fontSize: screenWidth * 0.03,
              height: 1.2,
              letterSpacing: 0,
              color: const Color(0xFF484848),
            ),
          ),
        ],
      ),
    );
  }
}
