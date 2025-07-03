import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/cards/card_model.dart';

class CardController extends GetxController {
  final List<CardModel> cards;
  final int initialIndex;
  final Duration? autoScrollDuration;

  late PageController pageController;
  late Timer _timer;

  CardController({
    required this.cards,
    this.initialIndex = 0,
    this.autoScrollDuration,
  }) : assert(initialIndex >= 0 && initialIndex < cards.length);

  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    currentIndex.value = initialIndex;
    pageController = PageController(initialPage: initialIndex);

    if (autoScrollDuration != null) {
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(autoScrollDuration!, (_) {
      final nextIndex = (currentIndex.value + 1) % cards.length;
      goToCard(nextIndex);
    });
  }

  void resetAutoScrollTimer() {
    if (autoScrollDuration != null) {
      _timer.cancel();
      _startAutoScroll();
    }
  }

  void goToCard(int index) {
    if (index >= 0 && index < cards.length) {
      currentIndex.value = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void nextCard() => goToCard((currentIndex.value + 1) % cards.length);
  void previousCard() => goToCard((currentIndex.value - 1 + cards.length) % cards.length);

  CardModel get currentCard => cards[currentIndex.value];

  @override
  void onClose() {
    if (autoScrollDuration != null) {
      _timer.cancel();
    }
    pageController.dispose();
    super.onClose();
  }
}
