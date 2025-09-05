import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../viewModels/endCustomer/chat/chat_controller.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final TextEditingController _controller = TextEditingController();
  final ChatController chatController = Get.find();

  void _send() {
    final text = _controller.text;
    if (text.trim().isEmpty) return;
    chatController.sendMessage(text);
    _controller.clear();
    // TODO: scroll to bottom after sending
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: context.theme.scaffoldBackgroundColor,
      child: Row(
        children: [
          // Text field container
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  // Text input
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Message....",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      minLines: 1,
                      maxLines: 5,
                    ),
                  ),
                  const SizedBox(width: 6),
                  _iconButton(Icons.image),
                  const SizedBox(width: 6),
                  _iconButton(Icons.attach_file),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Send Button
          Container(
            height: 44,
            width: 44,
            decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
            child: IconButton(onPressed: _send, icon: Icon(Icons.send, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      // decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, size: 20, color: Colors.black87),
    );
  }
}

