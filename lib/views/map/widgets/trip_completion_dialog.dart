import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/map/trip_completion_model.dart';
import 'package:avatar/views/map/widgets/feedback_button_widget.dart';
import 'package:avatar/views/map/widgets/star_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Dialog displayed after trip completion, shows trip details,
/// lets users rate their experience and provide feedback.
class TripCompletionDialog extends StatelessWidget {
  const TripCompletionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initializes controller for trip completion
    final controller = Get.put(TripCompletionController());

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Color(0xFF3586FC), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: Offset(4, 4),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            AppText.heading(
              'You have arrived at your location',
              fontSize: 28,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              color: Color(0xFFF79E1B),
            ),
            const SizedBox(height: 16),
            // Credit Points
            Obx(
              () => RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    const TextSpan(text: 'Congratulations! '),
                    TextSpan(
                      text: '${controller.tripData.creditPoints}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF79E1B),
                      ),
                    ),
                    const TextSpan(text: ' Credit points have been credited'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Trip Details
            Obx(
              () => Column(
                children: [
                  Row(
                    children: [
                      AppText.heading(
                        'Trip Duration: ',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFF79E1B),
                      ),
                      AppText.heading(
                        '${controller.tripData.tripDuration} min',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      AppText.heading(
                        'Distance: ',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFF79E1B),
                      ),
                      AppText.heading(
                        '${controller.tripData.distance} km',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Rating Section
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppText.heading('Rate your route', fontWeight: FontWeight.w400),
                Obx(
                  () => StarRatingWidget(
                    rating: controller.selectedRating,
                    onRatingChanged: controller.setRating,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Experience Feedback
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.heading(
                  'How was your experience?',
                  fontWeight: FontWeight.w400,
                ),
                Obx(
                  () => FeedbackButtonsWidget(
                    isLiked: controller.isLiked,
                    isDisliked: controller.isDisliked,
                    onLikePressed: controller.toggleLike,
                    onDislikePressed: controller.toggleDislike,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Done Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: controller.onDone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
