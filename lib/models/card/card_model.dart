import 'package:get/get.dart';

class CardModel {
  RxString title;       // Card title
  RxString imageUrl;    // Image URL
  RxDouble rating;      // Rating value
  RxString distance;    // Distance info
  RxString eta;         // Estimated time
  RxString price;       // Price info
  RxString timeAgo;     // Time since update
  RxBool isAccepted;    // Acceptance status

  CardModel({
    required String title,
    required String imageUrl,
    required double rating,
    required String distance,
    required String eta,
    required String price,
    required String timeAgo,
    bool isAccepted = false,
  })
      : title = title.obs,
        imageUrl = imageUrl.obs,
        rating = rating.obs,
        distance = distance.obs,
        eta = eta.obs,
        price = price.obs,
        timeAgo = timeAgo.obs,
        isAccepted = isAccepted.obs;
}
