// this is claim reward model for calim rewards screen

class ClaimedReward {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String claimedOn;
  final String expiredOn; // This is required
  final double points;

  ClaimedReward({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.claimedOn,
    required this.expiredOn,
    required this.points,
  });
}
