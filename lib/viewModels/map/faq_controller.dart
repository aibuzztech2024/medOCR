// lib/controllers/faq_controller.dart
import 'package:get/get.dart';

import '../../models/map/faq_model.dart';

class FAQController extends GetxController {
  final RxList<FAQCategory> faqCategories = <FAQCategory>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadFAQs();
  }

  Future<void> loadFAQs() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    faqCategories.assignAll([
      FAQCategory(
        title: 'Account & Subscription',
        items: [
          FAQItem(
            question: 'How do I create an account?',
            answer: 'Click on "Sign Up" and follow the registration process...',
          ),
          FAQItem(
            question: 'How do I upgrade to a premium subscription?',
            answer: 'Go to the Subscription section under Settings...',
          ),
          FAQItem(
            question: 'What is the Avatar system?',
            answer: 'The Avatar system is a platform where users...',
          ),
        ],
      ),
      FAQCategory(
        title: 'Avatar System',
        items: [
          FAQItem(
            question: 'What is the Avatar system?',
            answer: 'The Avatar system is a platform where users...',
          ),
        ],
      ),
    ]);

    isLoading.value = false;
  }
}
