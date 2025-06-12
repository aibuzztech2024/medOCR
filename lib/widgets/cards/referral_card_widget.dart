import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../core/constants/icons_paths.dart';
import '../../core/constants/image_paths.dart';
import '../../core/widgets/promotion_card_widget.dart';
import '../../models/cards/card_model.dart';

// TODO: Ui for refferal card

class ReferralCardWidget extends StatelessWidget {
  final List<CardModel> cards = [
    CardModel(
      title: "Invite a friend to\nand earn points!",
      imagePath: ImagePaths.referralCard1,
      buttonLabel: "Refer Now",
      gradientColors: [Colors.deepPurple.shade400, Colors.pink.shade100],
      icon: SvgPicture.asset(IconsPaths.materialSymbolsShareOutline),
      titleColor: Colors.white,
    ),
    CardModel(
      title: "Donate today and\n make a change!",
      imagePath: ImagePaths.referralCard2,
      buttonLabel: "Donate Now",
      gradientColors: [Color(0xFFDBEBE8), Color(0xFFDBEBE8)],
      icon: SvgPicture.asset(IconsPaths.uploadSquareSvgrepoCom),
      titleColor: Colors.black,
    ),
    CardModel(
      title: "Grab this coupon\n and save big now!",
      imagePath: ImagePaths.referralCard3,
      buttonLabel: "Redeem Now",
      gradientColors: [Color(0xFFD8DCFF), Color(0xFFD8DCFF)],
      icon: SvgPicture.asset(IconsPaths.streamlineDiscountPercentCoupon),
      titleColor: Colors.black,
    ),
  ];

  /// all thing which is required in the card is here

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Fixed height for the referral cards
      child: ReferralCard(
        autoScrollDuration: Duration(seconds: 3),
        cards: cards,
        onButtonPressed: (buttonLabel) {
          // TODO: Implement proper button action handling
          print('Button pressed: $buttonLabel');
          Get.snackbar(
            "Action",
            "$buttonLabel button clicked!",
            snackPosition: SnackPosition.TOP,
          );
        },
      ),
    );
  }
}
