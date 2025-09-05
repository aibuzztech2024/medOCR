import 'package:avatar/viewModels/pharmacy_support/ticket_controller.dart';
import 'package:avatar/views/pharmacy_support/widgets/bottom_chat.dart';
import 'package:avatar/views/pharmacy_support/widgets/ticket_card.dart';
import 'package:avatar/views/pharmacy_support/widgets/upload_issue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketDetails extends StatelessWidget {
  TicketDetails({super.key});

  final TicketControllerpharmacy ticketController = Get.put(
    TicketControllerpharmacy(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text('Ticket Details'),
        backgroundColor: const Color(0xFFF6F6F6),
      ),
      body: SafeArea(
        child: Obx(() {
          if (ticketController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (ticketController.ticket.value == null) {
            return const Center(child: Text('No ticket found'));
          } else {
            final ticket = ticketController.ticket.value!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TicketCard(ticket: ticket),
                  const SizedBox(height: 16),
                  addTicketImage(ticket),
                  const SizedBox(height: 16),
                  // TODO: Implement chatSection from Mohit
                ],
              ),
            );
          }
        }),
      ),
      bottomNavigationBar: bottomChat(),
      // bottomNavigationBar: bottomButtons(),
    );
  }
}
