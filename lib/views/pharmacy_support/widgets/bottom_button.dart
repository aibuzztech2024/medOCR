import 'package:flutter/material.dart';

Widget bottomButtons() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          offset: const Offset(0, -3), // Shadow at the top
          blurRadius: 6,
          spreadRadius: 0,
        ),
      ],
    ),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Go Back Button (Reduced width)
        SizedBox(
          width: 100, // Adjust this width as needed
          child: TextButton(
            onPressed: () {
              // Get.back(); // Or Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFECFFFF),
              foregroundColor: const Color(0xFF191919),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Go Back'),
          ),
        ),

        // Reopen Ticket Button (Full width)
        SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () {
              // Add your reopen ticket logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3AAFA9),
              foregroundColor: const Color(0xFFFFFDFA),
              elevation: 2, // Optional: you can reduce elevation or keep it
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Reopen Ticket'),
          ),
        ),
      ],
    ),
  );
}
