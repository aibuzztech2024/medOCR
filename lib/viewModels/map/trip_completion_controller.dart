import 'package:avatar/models/map/trip_completion_model.dart';
import 'package:get/get.dart';

/// Controller for trip completion, handles state and interactions related to trip details.
class TripCompletionController extends GetxController {
  // Observable trip data (this might normally come from backend API).
  final Rx<TripCompletionModel> _tripData =
      TripCompletionModel(
        creditPoints: 234,
        tripDuration: 24,
        distance: 12.5,
      ).obs;

  // User's rating for their trip
  final RxInt _selectedRating = 0.obs;

  // User's experience feedback (liked or not)
  final RxBool _isLiked = false.obs;
  final RxBool _isDisliked = false.obs;

  /// Currently displayed trip data
  TripCompletionModel get tripData => _tripData.value;

  /// Currently selected rating by the user
  int get selectedRating => _selectedRating.value;

  /// Whether the trip was liked by the user
  bool get isLiked => _isLiked.value;

  /// Whether the trip was disliked by the user
  bool get isDisliked => _isDisliked.value;

  /// Path to trip completion image
  final String tripImagePath = 'assets/images/trip_completion.png';

  /// Sets the trip rating
  void setRating(int rating) {
    _selectedRating.value = rating;

    // TODO (backend): Send this rating to backend API
    // e.g.: API.post('/trip/rate', body: {
    //   tripId: tripData.id,
    //   rating: rating,
    // });
  }

  /// Likes the trip
  void toggleLike() {
    _isLiked.value = !_isLiked.value;

    if (_isLiked.value) {
      _isDisliked.value = false;

      // TODO (backend):
    }
  }

  /// Dislikes the trip
  void toggleDislike() {
    _isDisliked.value = !_isDisliked.value;

    if (_isDisliked.value) {
      _isLiked.value = false;

      // TODO (backend):
    }
  }

  /// Done action after trip completion
  void onDone() {
    // Handle done button press
    print('Trip rated: $selectedRating stars');
    print('Liked: $isLiked, Disliked: $isDisliked');
    Get.back();

    // TODO (backend):
  }

  /// Update trip data with new information
  void updateTripData({
    int? creditPoints,
    int? tripDuration,
    double? distance,
  }) {
    _tripData.value = TripCompletionModel(
      creditPoints: creditPoints ?? tripData.creditPoints,
      tripDuration: tripDuration ?? tripData.tripDuration,
      distance: distance ?? tripData.distance,
      rating: selectedRating,
    );
  }
}
