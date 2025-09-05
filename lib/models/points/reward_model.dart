class Reward {
  final String? imageUrl;
  final String headerText;
  final String subheadingText;
  final String lowerHeadingText;
  final int currentPoints;
  final int totalPoints;
  final String couponCode;

  Reward({
    this.imageUrl,
    required this.headerText,
    required this.subheadingText,
    required this.lowerHeadingText,
    required this.currentPoints,
    required this.totalPoints,
    required this.couponCode,
  });
}
