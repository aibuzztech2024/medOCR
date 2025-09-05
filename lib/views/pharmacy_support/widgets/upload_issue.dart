import 'package:avatar/models/support_pharmacy/ticket_model.dart';
import 'package:flutter/material.dart';

Widget addTicketImage(Ticket ticket) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(left: 10, right: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFFD5D2CF)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ticket.issueType,
          style: const TextStyle(
            color: Color(0xFF191919),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '#${ticket.ticketId}',
          style: const TextStyle(color: Color(0xFF484848), fontSize: 14),
        ),
        const SizedBox(height: 16),
        Center(
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/ticket_upload.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            '10:30 AM',
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}
