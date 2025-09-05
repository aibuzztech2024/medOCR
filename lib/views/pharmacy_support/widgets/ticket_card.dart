import 'package:avatar/models/support_pharmacy/ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    // Direct color assignment
    final isResolved = ticket.status == 'Resolved';

    final Color statusTextColor =
        isResolved ? const Color(0xFF28A745) : const Color(0xFFCD6200);

    final Color statusBackgroundColor =
        isResolved ? const Color(0xFFC7E4CE) : const Color(0xFFF4D2B3);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFECFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0x4D6B79F5), // 30% opacity border color
          width: 1,
        ),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Issue Type Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Issue Type:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              Text(
                ticket.issueType,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF191919),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Submitted Date Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Submitted:',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Text(
                DateFormat('MMMM d yyyy').format(ticket.submittedDate),

                style: const TextStyle(fontSize: 14, color: Color(0xFF191919)),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Ticket ID Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ticket ID:',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Text(
                '#${ticket.ticketId}',
                style: const TextStyle(fontSize: 14, color: Color(0xFF191919)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ticket Status:',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusBackgroundColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  ticket.status,
                  style: TextStyle(color: statusTextColor, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
