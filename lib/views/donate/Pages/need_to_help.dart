import 'package:avatar/viewModels/donate/campaign_view_model.dart';
import 'package:avatar/views/donate/widgets/donate_campaign_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NeedToHelp extends StatelessWidget {
  NeedToHelp({super.key});
  final CampaignViewModel campaignController = Get.put(CampaignViewModel());

  @override
  Widget build(BuildContext context) {
    final height = Get.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Need to Help First!")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () => DonateCampaignCard(
                campaign: campaignController.campaign.value,
              ),
            ),
            SizedBox(height: height * 0.03),
            Obx(
              () => DonateCampaignCard(
                campaign: campaignController.campaign.value,
              ),
            ),
            Obx(
              () => DonateCampaignCard(
                campaign: campaignController.campaign.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
