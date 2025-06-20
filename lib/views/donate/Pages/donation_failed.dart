import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DonationFailed extends StatelessWidget {
  const DonationFailed({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;

    // Transparent system bars for full overlay effect
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
        backgroundColor: const Color(0xFFFF6F61).withOpacity(0.9), // full faint orange
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/error.svg',
              width: 48,
              height: 48,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: screenWidth * 0.8,
              child: const Text(
                "Payment failed.\nPlease try again later or contact support if the problem persists.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  height: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
