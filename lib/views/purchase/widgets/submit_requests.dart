import 'package:flutter/material.dart';

import '../../pharmacy/widgets/submit_request.dart';

class SubmitRequest extends StatelessWidget {
  SubmitRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 15),
          child: Column(children: [SubmitRequestPage()]),
        ),
      ),
    );
  }
}
