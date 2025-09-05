
enum Sender { user, bot }

class MessageModel {
  final String text;
  final DateTime time;
  final Sender sender;

  MessageModel({required this.text, required this.time, required this.sender});
}


