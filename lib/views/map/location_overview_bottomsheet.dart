import 'package:avatar/core/constants/image_paths.dart';
import 'package:avatar/views/map/widgets/reviews_widget.dart';
import 'package:avatar/views/map/widgets/star_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../models/map/location_overview_model.dart';
///use this to call
// LocationReviewWidget(
// location: LocationOverviewModel(
// title: 'Central Command',
// subtitle: 'General Hospital',
// review: ReviewModel(
// averageRating: 4.4,
// totalReviews: 157,
// starCounts: {5: 100, 4: 25, 3: 15, 2: 10, 1: 7},
//
// comments: [
// ReviewComment(
// name: 'Monika Singh',
// avatarUrl: 'https://i.pravatar.cc/100?img=1',
// rating: 5,
// comment: 'Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscem ipsum dolor sit amet, consectetur adipiscem ipsum dolor sit amet, consectetur adipiscem ipsum dolor sit amet, consectetur adipiscem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elit',
// date: DateTime.now().subtract(const Duration(days: 14)),
// ),
// ReviewComment(
// name: 'dipesh Singh',
// avatarUrl: 'https://i.pravatar.cc/100?img=1',
// rating: 3,
// comment: 'Could be better. Facilities are  okay.',
// date: DateTime.now().subtract(const Duration(days: 23)),
// ),
// ],
// ),
// ),
//
// onNavigate: () => print('Navigate tapped'),
// onBookmark: () => print('Bookmark tapped'),
// onShare: () => print('Share tapped'),
// onClose: () => print('Close tapped'),
// ),
class LocationReviewWidget extends StatefulWidget {
  final LocationOverviewModel location;
  final VoidCallback onNavigate;
  final VoidCallback onBookmark;
  final VoidCallback onShare;
  final VoidCallback onClose;
  final Color? color;

  const LocationReviewWidget({
    super.key,
    required this.location,
    required this.onNavigate,
    required this.onBookmark,
    required this.onShare,
    required this.onClose, this.color = Colors.orange,
  });

  @override
  State<LocationReviewWidget> createState() => _LocationReviewWidgetState();
}

class _LocationReviewWidgetState extends State<LocationReviewWidget> with TickerProviderStateMixin {
  final tabs = const ['Overview', 'Timings', 'Services', 'Reviews'];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            // Title and icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(widget.location.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(widget.location.subtitle, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 12,
                  children: [
                    InkWell(
                      onTap: widget.onNavigate,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(247, 248, 252, 1)),
                        child: SvgPicture.asset(AppIcons.direction, width: 20, height: 20, color: Colors.black),
                      ),
                    ),
                    InkWell(
                      onTap: widget.onBookmark,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(247, 248, 252, 1)),
                        child: SvgPicture.asset(AppIcons.bookmark, width: 20, height: 20, color: Colors.black),
                      ),
                    ),
                    InkWell(
                      onTap: widget.onShare,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(247, 248, 252, 1)),
                        child: SvgPicture.asset(AppIcons.share, width: 20, height: 20, color: Colors.black),
                      ),
                    ),
                    InkWell(
                      onTap: widget.onClose,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(247, 248, 252, 1)),
                        child: SvgPicture.asset(AppIcons.close, width: 18, height: 18, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            // TabBar
            TabBar(
              dividerHeight: 0.0,
              controller: _tabController,
              labelColor: widget.color,
              indicatorColor:  widget.color,
              unselectedLabelColor: Colors.black54,

              tabs: const [Tab(text: 'Overview'), Tab(text: 'Timings'), Tab(text: 'Services'), Tab(text: 'Reviews')],
            ),
            const SizedBox(height: 16),

            // TabBarView (now dynamic height!)
            Expanded(
              child: TabBarView(
                controller: _tabController,
                // physics: const NeverScrollableScrollPhysics(), // disable swipe if needed
                children: [
                  Center(child: Text("Overview")),
                  Center(child: Text("Timings")),
                  Center(child: Text("Services")),
                  _buildReviewsSection(widget.location.review),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsSection(ReviewModel review) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Column(
                children: [
                  Text(review.averageRating.toStringAsFixed(1), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  StarRating(rating: review.averageRating),
                  Text("(${review.totalReviews})"),
                ],
              ),
              const SizedBox(width: 16),
          
              // Progress bars
              Expanded(
                child: Column(
                  children: List.generate(5, (index) {
                    final star = 5 - index;
                    final count = review.starCounts[star] ?? 0;
                    final percent = review.totalReviews > 0 ? count / review.totalReviews : 0.0;
                          
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Text('$star'),
                          // const SizedBox(width: 4),
                          // const Icon(Icons.star, color: Colors.orange, size: 16),
                          const SizedBox(width: 8),
                          Expanded(child: LinearProgressIndicator(value: percent, minHeight: 6, backgroundColor: Colors.grey[200], color:  widget.color)),
                          const SizedBox(width: 8),
                          // Text('$count'),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        Reviews_widget(comments: review.comments,)
      ],
    );
  }
}
