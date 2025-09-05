class DonateCheckoutModel {
  // Title of the donation campaign
  final String title;

  // Location of the campaign
  final String location;

  // Image URL representing the campaign
  final String imageUrl;

  // Amount collected so far
  final int amountCollected;

  // Number of days left for the campaign
  final int daysLeft;

  // Progress percentage of the campaign funding (0.0 to 1.0)
  final double progressPercent;

  // Distance to the campaign location (in km or miles)
  final double distance;

  // Constructor to initialize all required fields
  DonateCheckoutModel({
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.amountCollected,
    required this.daysLeft,
    required this.progressPercent,
    required this.distance,
  });
}
