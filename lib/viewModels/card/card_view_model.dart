import 'package:get/get.dart';

import '../../models/card/card_model.dart';

class CardViewModel extends GetxController {
  // The card data model wrapped in this ViewModel
  final CardModel cardData;

  // Constructor to initialize the ViewModel with a CardModel instance
  CardViewModel(this.cardData);

  // Method to mark the card as accepted
  void accept() {
    cardData.isAccepted.value = true; // Update the observable isAccepted property
  }
}
