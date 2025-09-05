import 'package:avatar/core/widgets/feedback_and_rating_card.dart';
import 'package:avatar/core/widgets/feedback_card.dart';
import 'package:flutter/material.dart';

class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 90),
          FeedbackRatingWidget(),
          const SizedBox(height: 20),
          FeedbackWidget(rating: 4, feedbackText: 'This is a test feedback'),
        ],
      ),
    );
  }
}
