import 'package:get/get.dart';
import '../../models/ticket/ticket_model.dart';

class TicketController extends GetxController {
  // List holding all tickets (observable for reactivity)
  var tickets = <TicketModel>[].obs;

  // List holding filtered tickets based on search (observable)
  var filteredTickets = <TicketModel>[].obs;

  // Current search query string (observable)
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTickets(); // Initialize with static ticket data (can be replaced with dynamic data later)

    // Set up listener to filter tickets whenever searchQuery changes
    ever(searchQuery, (_) => _filterTickets());
  }

  // Fetch tickets - currently generates static list of tickets
  void fetchTickets() {
    tickets.value = List.generate(12, (index) {
      return TicketModel(
        title: 'Payment Issue',
        ticketId: '#342314232',
        date: 'Mar 23, 2022',
        status: index % 3 == 0 ? 'In Progress' : 'Resolved',
      );
    });

    // Initialize filteredTickets with all tickets initially
    filteredTickets.value = tickets;
  }

  // Filters tickets based on searchQuery and updates filteredTickets
  void _filterTickets() {
    final query = searchQuery.value.toLowerCase().trim();

    if (query.isEmpty) {
      // If search is empty, show all tickets
      filteredTickets.value = tickets;
    } else {
      // Otherwise, filter tickets where any field contains the query text
      filteredTickets.value = tickets.where((ticket) {
        return ticket.title.toLowerCase().contains(query) ||
            ticket.ticketId.toLowerCase().contains(query) ||
            ticket.status.toLowerCase().contains(query) ||
            ticket.date.toLowerCase().contains(query);
      }).toList();
    }
  }

  // Update the current search query
  void setSearchQuery(String query) {
    searchQuery.value = query;
  }
}
