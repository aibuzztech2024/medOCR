import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:avatar/viewModels/pharmacy_app/chat/chat_controller.dart';

class SuggestionCard extends StatelessWidget {
  const SuggestionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatControllerpharmacy controller = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),

          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(controller.suggestions.length, (index) {
            final text = controller.suggestions[index];
            return Column(
              children: [
                InkWell(
                  onTap: () => controller.selectSuggestion(text),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    child: Align(alignment: Alignment.centerLeft, child: Text(text, style: const TextStyle(color: Colors.black87))),
                  ),
                ),
                if (index < controller.suggestions.length - 1) const Divider(height: 1, thickness: 1),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final DateTime time;
  final bool isUser;

  const MessageBubble({Key? key, required this.text, required this.time, required this.isUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bgColor = isUser ? Colors.teal.shade50 : Colors.white;
    final textColor = Colors.black;
    final radius =
        isUser
            ? const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))
            : const BorderRadius.only(topRight: Radius.circular(12), bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Column(
        crossAxisAlignment: align,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: radius,
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 2, offset: const Offset(0, 1))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(text, style: TextStyle(color: textColor)),
                const SizedBox(height: 6),
                Text(
                  '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
