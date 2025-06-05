import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/map/referral_model.dart';
//Todo:referal card controller

class ReferController extends GetxController {
  final currentIndex = 0.obs;

  final List<ReferCardModel> cards = [
    ReferCardModel(
      title: "Invite a friend to\nand earn points!",
      imagePath: "assets/images/gradient-affiliate-marketing-illustration.png",
      buttonLabel: "Refer Now",
      gradientColors: [Colors.deepPurple.shade400, Colors.pink.shade100],
      icon: Icons.share,
      titleColor: Colors.white,
    ),
    ReferCardModel(
      title: "Donate today and\n make a change!",
      imagePath: "assets/images/gradient-affiliate-marketing-illustration4.png",
      buttonLabel: "Donate Now",
      gradientColors: [Color(0xFFDBEBE8), Color(0xFFDBEBE8)],
      icon: Icons.volunteer_activism,
      titleColor: Colors.black,
    ),
    ReferCardModel(
      title: "Grab this coupon\n and save big now!",
      imagePath: "assets/images/gradient-affiliate-marketing-illustration3.png",
      buttonLabel: "Redeem Now",
      gradientColors: [Color(0xFFD8DCFF), Color(0xFFD8DCFF)],
      icon: Icons.card_giftcard,
      titleColor: Colors.black,
    ),
  ];

  @override
  void onInit() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      currentIndex.value = (currentIndex.value + 1) % cards.length;
    });
    super.onInit();
  }

  void onButtonPressed(String label) {
    Get.snackbar("Action", "$label button clicked!");
  }
}