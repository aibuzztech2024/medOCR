// lib/dummy_data/ticket_dummy.dart

import 'dart:async';
import 'package:avatar/models/support_pharmacy/ticket_model.dart';

class TicketDummy {
  // Dummy Ticket
  static final Ticket _dummyTicket = Ticket(
    ticketId: '23451556',
    issueType: 'Payment Issue',
    submittedDate: DateTime(2022, 3, 16),
    status: 'Resolved',
  );

  // Simulated API fetch with delay
  Future<Ticket> fetchTicket() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate API delay
    return _dummyTicket;
  }
}
