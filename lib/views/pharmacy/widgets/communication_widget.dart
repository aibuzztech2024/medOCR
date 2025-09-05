import 'package:avatar/core/constants/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommunicationWidget extends StatelessWidget {
  const CommunicationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.pharmacy_PrimaryColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Text(
              'Communications (4 unread)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            Spacer(),
            SvgPicture.asset(
              'assets/icons/communications_icon.svg',
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
