import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../models/ticket/ticket_model.dart';
import '../../viewModels/ticket/ticket_controller.dart';

class TicketHistoryPage extends StatelessWidget {
  const TicketHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller using GetX
    final TicketController controller = Get.put(TicketController());

    // Get screen dimensions using GetX (for responsiveness)
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Ticket History',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.01,
        ),
        child: Column(
          children: [
            // Search input field
            _buildSearchBar(controller),

            SizedBox(height: screenHeight * 0.02),

            // Header row with title and filter icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Tickets',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    // TODO: Implement filter functionality
                    debugPrint('Filter icon tapped');
                  },
                  borderRadius: BorderRadius.circular(32),
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    child: SvgPicture.asset(
                      'assets/icons/filter.svg',
                      width: screenWidth * 0.06,
                      height: screenWidth * 0.06,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.02),

            // Scrollable ticket list that reacts to search/filter changes
            Expanded(
              child: Obx(() {
                // Show message if no results found
                if (controller.filteredTickets.isEmpty) {
                  return const Center(
                    child: Text(
                      'No tickets found',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                // Scrollable list of tickets
                return ListView.separated(
                  itemCount: controller.filteredTickets.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: screenHeight * 0.015),
                  itemBuilder: (context, index) {
                    final ticket = controller.filteredTickets[index];
                    return _buildTicketCard(ticket, screenWidth, screenHeight);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a styled and responsive search bar.
  Widget _buildSearchBar(TicketController controller) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        onChanged: controller.setSearchQuery,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.black, size: 28),
          hintText: 'Search Help',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
        cursorColor: Colors.grey,
      ),
    );
  }

  /// Builds a responsive ticket card UI.
  Widget _buildTicketCard(TicketModel ticket, double width, double height) {
    final badgeColor =
    ticket.status == "Resolved" ? Colors.green[100] : Colors.orange[100];
    final textColor =
    ticket.status == "Resolved" ? Colors.green : Colors.orange;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        debugPrint('Tapped ticket: ${ticket.ticketId}');
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.015,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 14,
              offset: Offset(0, 6),
            )
          ],
        ),
        child: Row(
          children: [
            // Ticket info on the left side
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Text(
                    ticket.ticketId,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Text(
                    ticket.date,
                    style: const TextStyle(
                      color: Colors.black38,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // Status badge and arrow icon
            Row(
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    ticket.status,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(width: width * 0.02),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.black87,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
