import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/widgets/promotion_card_widget.dart';
import '../../../models/map/card_model.dart';

// TODO: Ui for refferal card

class ReferralCardWidget extends StatelessWidget {
  final List<CardModel> cards = [
    CardModel(
      title: "Invite a friend to\nand earn points!",
      imagePath: "assets/images/gradient-affiliate-marketing-illustration.png",
      buttonLabel: "Refer Now",
      gradientColors: [Colors.deepPurple.shade400, Colors.pink.shade100],
      icon: SvgPicture.asset('assets/icons/material-symbols_share-outline.svg'),
      titleColor: Colors.white,
    ),
    CardModel(
      title: "Donate today and\n make a change!",
      imagePath: "assets/images/gradient-affiliate-marketing-illustration4.png",
      buttonLabel: "Donate Now",
      gradientColors: [Color(0xFFDBEBE8), Color(0xFFDBEBE8)],
      icon: SvgPicture.asset('assets/icons/upload-square-svgrepo-com (1).svg'),
      titleColor: Colors.black,
    ),
    CardModel(
      title: "Grab this coupon\n and save big now!",
      imagePath: "assets/images/gradient-affiliate-marketing-illustration3.png",
      buttonLabel: "Redeem Now",
      gradientColors: [Color(0xFFD8DCFF), Color(0xFFD8DCFF)],
      icon: SvgPicture.asset('assets/icons/streamline_discount-percent-coupon.svg'),
      titleColor: Colors.black,
    ),
  ];

  /// all thing which is required in the card is here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReferralCard(
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
