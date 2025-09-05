import 'package:avatar/views/hospital/Widgets/chat_list_widget.dart';
import 'package:flutter/material.dart';

class OrderDiscussionPage extends StatefulWidget {
  const OrderDiscussionPage({super.key});

  @override
  State<OrderDiscussionPage> createState() => _OrderDiscussionPageState();
}

class _OrderDiscussionPageState extends State<OrderDiscussionPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [ChatListWidget()]),
      ),
    );
  }
}
