import 'package:avatar/views/advertiser/donate/donation_payment_controller.dart';
import 'package:avatar/views/advertiser/donate/donation_detailed_read_more_controller.dart';
import 'package:avatar/views/advertiser/widget/amount_breakdown_card.dart';
import 'package:avatar/views/advertiser/widget/donate_payment_card.dart';
import 'package:avatar/views/advertiser/widget/donation_amount_input.dart';
import 'package:avatar/views/advertiser/widget/payment_option_card.dart';
import 'package:avatar/views/advertiser/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Payment card widget that displays donation organization details
class DonationPaymentCard extends StatelessWidget {
  final DonationCardModel1 donation;

  const DonationPaymentCard({Key? key, required this.donation})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 366,
      height: 364,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Organization image container
          Container(
            width: 366,
            height: 255,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              image: DecorationImage(
                image: NetworkImage(donation.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Organization details container
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Organization title
                      Text(
                        donation.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D3748),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Get.height * 0.001),
                      // Organization description
                      Text(
                        donation.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF718096),
                          height: 1.4,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
