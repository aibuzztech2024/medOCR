import 'package:get/get.dart';
import '../../models/donate/campaign_model.dart';

/// ViewModel managing the campaign data using GetX.
class CampaignViewModel extends GetxController {
  /// Observable campaign data.
  final Rx<CampaignModel> campaign = CampaignModel(
    title: "Save a child from hunger, and give them better life",
    location: "Zenith Hospital, Malad East",
    amountCollected: 40119,
    daysLeft: 10,
    distanceKm: 0.8,
    progressPercent: 77,
    description:
    "Support underprivileged children by providing them with the opportunities they deserve — access to quality education, nutritious daily meals, and a nurturing environment. Millions of children from marginalized communities face daily hardships: empty stomachs, lack of school supplies, and a future filled with uncertainty. With your help, we can fund books, uniforms, transportation, hygiene essentials, and ensure no child is held back due to poverty. Every donation brings us closer to a world where every child can dream, learn, and thrive with dignity.",
    organizationName: "Bharat Seva Mandal",
    organizationWebsite: "www.bharatsevamandal.com",
    imageUrl: "assets/images/campaign.jpg",
    organizationLogoUrl: "assets/images/bsm.jpg",
  ).obs;

  /// Method to update the campaign if needed
  void updateCampaign(CampaignModel newCampaign) {
    campaign.value = newCampaign;
  }
}
