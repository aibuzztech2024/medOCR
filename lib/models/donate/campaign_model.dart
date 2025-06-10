/// Campaign data model class representing a fundraising campaign.
class CampaignModel {
  final String title;
  final String location;
  final double amountCollected;
  final int daysLeft;
  final double distanceKm;
  final int progressPercent;

  final String description;
  final String organizationName;
  final String organizationWebsite;
  final String imageUrl;
  final String organizationLogoUrl;

  CampaignModel({
    required this.title,
    required this.location,
    required this.amountCollected,
    required this.daysLeft,
    required this.distanceKm,
    required this.progressPercent,
    required this.description,
    required this.organizationName,
    required this.organizationWebsite,
    required this.imageUrl,
    required this.organizationLogoUrl,
  });
}
