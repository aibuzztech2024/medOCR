// lib/controllers/ticket_controller.dart
import 'package:get/get.dart';
import 'package:avatar/models/support_pharmacy/ticket_model.dart';
import 'package:avatar/models/support_pharmacy/dummy_data.dart';

class TicketControllerpharmacy extends GetxController {
  var ticket = Rxn<Ticket>(); // Nullable, observable ticket
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTicket();
  }

  void fetchTicket() async {
    isLoading.value = true;
    ticket.value = await TicketDummy().fetchTicket();
    isLoading.value = false;
  }
}
