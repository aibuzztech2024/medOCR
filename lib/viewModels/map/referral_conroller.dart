import 'dart:async';

import 'package:get/get.dart';

import '../../models/map/card_model.dart';
//Todo: card controller

// TODO: Consider adding swipe detection logic here
class CardController extends GetxController {
  final List<CardModel> cards;
  final int initialIndex;
  final Duration? autoScrollDuration;
  late Timer _timer;

  CardController({
    required this.cards,
    this.initialIndex = 0,
    this.autoScrollDuration,
  }) : assert(
         initialIndex >= 0 && initialIndex < cards.length,
       ); // TODO: Add better error handling

  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    currentIndex.value = initialIndex;
    // TODO: Add auto-rotate functionality if needed
    if (autoScrollDuration != null) {
      _timer = Timer.periodic(autoScrollDuration!, (timer) {
        currentIndex.value = (currentIndex.value + 1) % cards.length;
      });
    }
  }

  @override
  void onClose() {
    // Cancel the timer when the controller is disposed
    if (autoScrollDuration != null) {
      _timer.cancel();
    }
    super.onClose();
  }

  CardModel get currentCard => cards[currentIndex.value];

  // TODO: Add methods for manual navigation (next/previous)
}
