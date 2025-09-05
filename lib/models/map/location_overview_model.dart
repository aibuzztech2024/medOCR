class LocationOverviewModel {
  final String title;
  final String subtitle;
  final ReviewModel review;

  LocationOverviewModel({required this.title, required this.subtitle, required this.review});
}

class ReviewModel {
  final double averageRating;
  final int totalReviews;
  final Map<int, int> starCounts; // {5: 100, 4: 30, ...}
  final List<ReviewComment> comments;

  ReviewModel({required this.averageRating, required this.totalReviews, required this.starCounts, required this.comments});
}

class ReviewComment {
  final String name;
  final String avatarUrl;
  final int rating; // 1-5
  final String comment;
  final DateTime date;

  ReviewComment({required this.name, required this.avatarUrl, required this.rating, required this.comment, required this.date});
}
