import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriendsController {
  final BuildContext context;

  InviteFriendsController(this.context);

  void copyReferralCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    Get.snackbar(
      'Success',
      'Code copied!',
      snackPosition: SnackPosition.BOTTOM, // or TOP
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
    );
  }

  //TODO change this referral code
  void shareReferral(String code) {
    final message = 'Join this awesome app using my referral code: $code';
    Share.share(message);
  }
}
