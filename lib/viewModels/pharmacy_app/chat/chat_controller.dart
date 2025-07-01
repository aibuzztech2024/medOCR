import 'package:get/get.dart';
import '../../../models/chat/message_model.dart';

class ChatController extends GetxController {
  // List of messages in chat
  final messages = <MessageModel>[].obs;

  // List of suggestion strings
  final suggestions =
      <String>[
        'Is Cash on Delivery (COD) available?',
        'How do I apply a coupon or discount code?',
        'How do I get a refund if my order is cancelled?',
        // TODO: Add more suggestions or load dynamically if needed
      ].obs;

  // Add a user message and simulate bot response
  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    final userMessage = MessageModel(
      text: text.trim(),
      time: DateTime.now(),
      sender: Sender.user,
    );
    messages.add(userMessage);

    // TODO: Remove suggestion if desired after selection

    // Simulate bot response after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _addBotResponse(text);
    });
  }

  void _addBotResponse(String userText) {
    // TODO: Replace this logic with actual response generation or static responses
    String responseText;
    // Simple static mapping for demo
    if (userText.toLowerCase().contains('cod') ||
        userText.toLowerCase().contains('cash on delivery')) {
      responseText = 'Yes, Cash on Delivery (COD) is available.';
    } else if (userText.toLowerCase().contains('coupon')) {
      responseText =
          'To apply a coupon, go to the cart and enter the code in the coupon field.';
    } else if (userText.toLowerCase().contains('refund')) {
      responseText =
          'You will receive a refund within 5-7 business days after cancellation.';
    } else {
      responseText = "I'm here to help! Could you please elaborate?";
    }
    final botMessage = MessageModel(
      text: responseText,
      time: DateTime.now(),
      sender: Sender.bot,
    );
    messages.add(botMessage);
  }

  // When a suggestion is tapped
  void selectSuggestion(String suggestion) {
    sendMessage(suggestion);
    // Optionally, you may remove the suggestion from list or mark it used
  }
}
