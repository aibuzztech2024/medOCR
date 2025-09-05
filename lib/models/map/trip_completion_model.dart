class TripCompletionModel {
  final int creditPoints;
  final int tripDuration; // in minutes
  final double distance; // in km
  final int rating;

  TripCompletionModel({
    required this.creditPoints,
    required this.tripDuration,
    required this.distance,
    this.rating = 0,
  });
}