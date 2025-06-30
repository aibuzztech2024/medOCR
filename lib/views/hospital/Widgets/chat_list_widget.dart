import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/hospital/chat_model.dart';
import '../../../viewModels/hospital/chat_controller.dart';

class ChatListWidget extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());

  ChatListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.chatList.length,
        itemBuilder: (context, index) {
          ChatModel chat = controller.chatList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Optional Avatar/Icon

                const SizedBox(width: 12),
                // Title + Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(chat.subtitle),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      chat.time,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    // Unread Badge - show only on some chats for demo
                    if (index % 3 == 1)  // For demo, show on every 3rd item
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '1',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
