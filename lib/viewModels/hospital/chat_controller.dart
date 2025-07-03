import 'package:get/get.dart';

import '../../models/hospital/chat_model.dart';


class ChatController extends GetxController {
  RxList<ChatModel> chatList = <ChatModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchChatData();
  }

  void fetchChatData() {
    // Simulate API Data
    chatList.value = List.generate(10, (index) {
      return ChatModel(
        title: 'Monika Singh',
        subtitle: 'Do you offer delivery for this ?',
        time: '12:30 PM',
      );
    });
  }
}
