import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:avatar/core/constants/appColors.dart';
import 'package:avatar/models/pharmacy_app/purchase/productModal.dart';
import 'package:avatar/views/pharmacy_app/purchase/purchase_page.dart';
import 'package:avatar/views/pharmacy_app/purchase/searchTab_view.dart';
import 'package:avatar/views/pharmacy_app/purchase/widgets/dropdownfield.dart';
import 'package:avatar/views/pharmacy_app/purchase/widgets/product_card.dart';
import 'package:avatar/viewModels/pharmacy_app/purchase/search_controller.dart';
import 'package:avatar/viewModels/pharmacy_app/chat/chat_controller.dart';

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
  final ChatControllerpharmacy chatController = Get.find();

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
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
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
            decoration: BoxDecoration(
              color: AppColors.pharmacy_PrimaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: _send,
              icon: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      // decoration: BoxDecoration(color: AppColors.pharmacy_PrimaryColor.shade50, borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, size: 20, color: Colors.black87),
    );
  }
}
