import 'package:flutter/material.dart';

Widget bottomChat() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: const Color(0x26000000), // 15% black shadow
          offset: const Offset(0, -3),
          blurRadius: 6,
        ),
      ],
    ),
    child: Row(
      children: [
        // TextField and Attachments Container with F6F6F6 Background
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(
                0xFFF6F6F6,
              ), // Background color for this section
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                // Text Field
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Message..',
                      hintStyle: TextStyle(
                        color: Color(0xFF191919), // Text color updated here
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),

                // First Circle Avatar (Image Icon)
                CircleAvatar(
                  backgroundColor: const Color(0xFFECFFFF),
                  radius: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.image,
                      color: Colors.black54,
                      size: 20,
                    ),
                    onPressed: () {
                      // Image picker functionality
                    },
                  ),
                ),
                const SizedBox(width: 6),

                // Second Circle Avatar (Attach File Icon)
                CircleAvatar(
                  backgroundColor: const Color(0xFFECFFFF),
                  radius: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.attach_file,
                      color: Colors.black54,
                      size: 20,
                    ),
                    onPressed: () {
                      // Attachment functionality
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 6),

        // Send Button (Separate, no background container)
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF3AAFA9), // Teal color
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              // Send message functionality
            },
            icon: const Icon(Icons.send, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
