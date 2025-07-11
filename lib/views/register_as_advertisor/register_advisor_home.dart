import 'package:avatar/views/register_as_advertisor/widgets/advertisor_appbar.dart';
import 'package:avatar/views/register_as_advertisor/widgets/post_performance_overview.dart';
import 'package:flutter/material.dart';

class RegisterAdvisorHome extends StatelessWidget {
  const RegisterAdvisorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AdvertisorAppbar(
                backgroundColor: Colors.white,
                onNewPostPressed: () {
                  // TODO Custom action for new post
                  print('Custom new post action');
                },
                onGlobePressed: () {
                  // TODO Custom action for globe
                  print('Custom globe action');
                },
                onShoppingCartPressed: () {
                  // TODO Custom action for shopping cart
                  print('Custom shopping cart action');
                },
                onNotificationPressed: () {
                  // Custom action for notifications
                  print('Custom notification action');
                },
              ),
              PostPerformanceOverview(),
            ],
          ),
        ),
      ),
    );
  }
}
