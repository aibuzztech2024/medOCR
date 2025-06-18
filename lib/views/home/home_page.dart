import 'package:avatar/models/map/location_overview_model.dart';
import 'package:flutter/material.dart';

import '../map/location_overview_bottomsheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LocationReviewWidget(
          location: LocationOverviewModel(
            title: 'Central Command',
            subtitle: 'General Hospital',
            review: ReviewModel(
              averageRating: 4.4,
              totalReviews: 157,
              starCounts: {5: 100, 4: 25, 3: 15, 2: 10, 1: 7},

              comments: [
                ReviewComment(
                  name: 'Monika Singh',
                  avatarUrl: 'https://i.pravatar.cc/100?img=1',
                  rating: 5,
                  comment: 'Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscem ipsum dolor sit amet, consectetur adipiscem ipsum dolor sit amet, consectetur adipiscem ipsum dolor sit amet, consectetur adipiscem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elit',
                  date: DateTime.now().subtract(const Duration(days: 14)),
                ),
                ReviewComment(
                  name: 'dipesh Singh',
                  avatarUrl: 'https://i.pravatar.cc/100?img=1',
                  rating: 3,
                  comment: 'Could be better. Facilities are  okay.',
                  date: DateTime.now().subtract(const Duration(days: 23)),
                ),
              ],
            ),
          ),

          onNavigate: () => print('Navigate tapped'),
          onBookmark: () => print('Bookmark tapped'),
          onShare: () => print('Share tapped'),
          onClose: () => print('Close tapped'),
        ),
      ),
    );
  }
}
