import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/map/location_overview_model.dart';

class ReviewController extends GetxController {
  final RxList<ReviewComment> filteredComments = <ReviewComment>[].obs;

  final RxString selectedFilter = 'Newest'.obs;

  void setReviews(List<ReviewComment> reviews) {
    filteredComments.assignAll(reviews);
    sortReviews();
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
    sortReviews();
  }

  void sortReviews() {
    final List<ReviewComment> sorted = List.from(filteredComments);

    switch (selectedFilter.value) {
      case 'Highest':
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Lowest':
        sorted.sort((a, b) => a.rating.compareTo(b.rating));
        break;
      case 'Newest':
      default:
        sorted.sort((a, b) => b.date.compareTo(a.date));
    }

    filteredComments.assignAll(sorted);
  }

  String getRelativeTime(DateTime date) {
    final Duration diff = DateTime.now().difference(date);
    if (diff.inDays >= 7) {
      final weeks = (diff.inDays / 7).floor();
      return "$weeks week${weeks > 1 ? 's' : ''} ago";
    } else if (diff.inDays >= 1) {
      return "${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago";
    } else if (diff.inHours >= 1) {
      return "${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago";
    } else {
      return "Just now";
    }
  }
}

