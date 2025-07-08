import 'package:avatar/views/register_as_advertisor/widgets/post_performance_overview.dart';
import 'package:flutter/material.dart';

class RegisterAdvisorHome extends StatelessWidget {
  const RegisterAdvisorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [PostPerformanceOverview()]),
      ),
    );
  }
}
