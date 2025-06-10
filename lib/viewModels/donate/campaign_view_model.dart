import 'package:get/get.dart';
import '../../models/donate/campaign_model.dart';

/// ViewModel managing the campaign data and business logic using GetX.
class CampaignViewModel extends GetxController {
  /// Observable campaign data to update the UI reactively.
  final Rx<CampaignModel> campaign = CampaignModel(
    title: "Save a child from hunger, and give them better life",
    location: "Zenith Hospital, Malad East",
    amountCollected: 40119,
    daysLeft: 10,
    distanceKm: 0.8,
    progressPercent: 77,

    description: "Support underprivileged children by providing them with the opportunities they deserve — access to quality education, nutritious daily meals, and a nurturing environment. Millions of children from marginalized communities face daily hardships: empty stomachs, lack of school supplies, and a future filled with uncertainty. With your help, we can fund books, uniforms, transportation, hygiene essentials, and ensure no child is held back due to poverty. Every donation brings us closer to a world where every child can dream, learn, and thrive with dignity.Support underprivileged children by providing them with access to education, nutritious meals, and a safe environment to grow. Your contribution helps fund school supplies, uniforms, daily meals, and essential care for children in vulnerable communities. Together, we can break the cycle of poverty and give these young minds a brighter, more hopeful future.",


    organizationName: "Bharat Seva Mandal",
    organizationWebsite: "www.bharatsevamandal.com",
    imageUrl: "assets/images/campaign.jpg",
    organizationLogoUrl: "assets/images/bsm.jpg",
  ).obs;

  /// Updates the campaign data with new values.
  void updateCampaign(CampaignModel newCampaign) {
    campaign.value = newCampaign;
  }
}
