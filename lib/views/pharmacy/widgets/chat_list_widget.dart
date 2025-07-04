import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatModel {
  final String title;
  final String subtitle;
  final String time;

  ChatModel({required this.title, required this.subtitle, required this.time});
}

class ChatController extends GetxController {
  RxList<ChatModel> chatList = <ChatModel>[].obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchChatData();
  }

  void fetchChatData() {
    // Dummy data
    chatList.value = List.generate(10, (index) {
      return ChatModel(
        title: 'Monika Singh',
        subtitle: 'Do you offer delivery for this ?',
        time: '12:30 PM',
      );
    });
  }

  List<ChatModel> get filteredList {
    if (searchQuery.value.isEmpty) return chatList;
    return chatList
        .where((chat) =>
    chat.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        chat.subtitle.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }
}

class ChatListWidget extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());

  ChatListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final chats = controller.filteredList;

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: chats.length,
        itemBuilder: (context, index) {
          ChatModel chat = chats[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 12),
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
                    if (index % 3 == 1)
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
