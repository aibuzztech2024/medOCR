import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../viewModels/donate/campaign_view_model.dart';
import '../widgets/campaign_card_view.dart';
import '../widgets/organization_info.dart';


class CampaignDetailsPage extends StatelessWidget {
  final CampaignViewModel controller = Get.put(CampaignViewModel());

  CampaignDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Save a child from hunger',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final campaign = controller.campaign.value;

        return SingleChildScrollView(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CampaignCardView(campaign: campaign),
              SizedBox(height: height * 0.02),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: height * 0.01),
              Text(
                campaign.description,
                style: TextStyle(
                  fontSize: width * 0.037,
                  height: 1.5,
                ),
              ),
              SizedBox(height: height * 0.04),

              OrganizationInfoRow(
                logoUrl: campaign.organizationLogoUrl,
                organizationName: campaign.organizationName,
                organizationWebsite: campaign.organizationWebsite,
              ),

              SizedBox(height: height * 0.04),
              Wrap(
                spacing: width * 0.04,
                runSpacing: height * 0.02,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.42,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFF7E6),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Go Back",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.42,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement donation functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF99F1B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Donate Now",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.04),
            ],
          ),
        );
      }),
    );
  }
}
