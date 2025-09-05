import 'package:avatar/views/pharmacy/widgets/communication_widget.dart';
import 'package:avatar/views/pharmacy/widgets/delivery_status.dart';
import 'package:avatar/views/pharmacy/widgets/feedback_and_rating_card.dart';
import 'package:avatar/views/pharmacy/widgets/feedback_card.dart';
import 'package:avatar/views/pharmacy/widgets/invoice_card.dart';
import 'package:avatar/views/pharmacy/widgets/order_card.dart';
import 'package:avatar/views/pharmacy/widgets/profile_tile.dart';
import 'package:avatar/views/pharmacy/widgets/qr_delivery_component.dart';
import 'package:flutter/material.dart';
import 'package:avatar/core/constants/appColors.dart';
import 'package:flutter_svg/svg.dart';

class PurchaseDetails extends StatefulWidget {
  const PurchaseDetails({super.key});

  @override
  State<PurchaseDetails> createState() => _PurchaseDetailsState();
}

class _PurchaseDetailsState extends State<PurchaseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Center(
              child: Text(
                'Purchase',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              'Buy Better, Save More & Simplify Procurement',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            CommunicationWidget(),
            const SizedBox(height: 12),
            ProfileTileList(),
            OrderCardScreen(),
            const StatusView(),
            QRDeliveryComponent(),
            const SizedBox(height: 12),
            const StatusView(),
            const SizedBox(height: 12),
            InvoiceCard(),
            const SizedBox(height: 12),
            FeedbackSection(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
