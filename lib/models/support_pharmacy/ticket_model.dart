class Ticket {
  final String ticketId;
  final String issueType;
 final DateTime submittedDate;
  final String status;

  Ticket({
    required this.ticketId,
    required this.issueType,
    required this.submittedDate,
    required this.status,
  });

  //when api integrate
  // factory Ticket.fromJson(Map<String, dynamic> json) {
  //   return Ticket(
  //     ticketId: json['ticketId'],
  //     issueType: json['issueType'],
  //     submittedDate: DateTime.parse(json['submittedDate']),
  //     status: json['status'],
  //   );
  // }
}
