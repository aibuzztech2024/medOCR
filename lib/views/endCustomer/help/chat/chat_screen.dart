import 'package:avatar/views/endCustomer/help/chat/widgets/chat_input_field.dart';
import 'package:avatar/views/endCustomer/help/chat/widgets/messages_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/chat/message_model.dart';
import '../../../../viewModels/endCustomer/chat/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController controller = Get.put(ChatController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ever(controller.messages, (_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Chat list area
            Expanded(
              child: Obx(
                () => ListView(
                  controller: _scrollController,
                  children: [
                    const SizedBox(height: 8),

                    ChatIntroHeader(),

                    const SizedBox(height: 26),

                    // Chat messages
                    ...controller.messages.map((msg) {
                      return Align(
                        alignment: msg.sender == Sender.user ? Alignment.centerRight : Alignment.centerLeft,
                        child: MessageBubble(text: msg.text, time: msg.time, isUser: msg.sender == Sender.user),
                      );
                    }).toList(),
                    const SizedBox(height: 00), // Space for input field
                  ],
                ),
              ),
            ),

            // Chat input field fixed at bottom
            const ChatInputField(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatIntroHeader extends StatelessWidget {
  const ChatIntroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320, // Enough space for header + card overlap
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Orange header
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Hi there!', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('I am PharmaBot', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(height: 4),
                    Text('How can I assist you?', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
                const Icon(Icons.close, color: Colors.white),
              ],
            ),
          ),

          // Suggestion Card
          Positioned(bottom: -20, left: 0, right: 20, child: Align(alignment: Alignment.centerLeft, child: SuggestionCard())),
        ],
      ),
    );
  }
}
