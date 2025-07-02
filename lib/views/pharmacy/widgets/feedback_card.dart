import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// Modified FeedbackWidget that accepts direct data parameters
class FeedbackWidget extends StatelessWidget {
  final int rating;
  final String feedbackText;
  final String postedTime;

  const FeedbackWidget({
    Key? key,
    required this.rating,
    required this.feedbackText,
    required this.postedTime,
  }) : super(key: key);

  String get currentTime {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive dimensions
        final containerWidth =
            constraints.maxWidth > 400 ? 366.0 : constraints.maxWidth * 0.9;
        final containerHeight =
            constraints.maxHeight > 300 ? 164.0 : constraints.maxHeight * 0.85;

        return Center(
          child: Container(
            width: containerWidth,
            height: containerHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0x4D3AAFA9), width: 1),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: containerWidth * 0.04,
                vertical: containerHeight * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Your rating and feedback',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: containerHeight * 0.05),

                  // Display star rating
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starIndex = index + 1;
                        final isSelected = starIndex <= rating;

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: containerWidth * 0.015,
                          ),
                          child: SvgPicture.asset(
                            isSelected
                                ? 'assets/icons/kid_star_filled.svg'
                                : 'assets/icons/kid_star_outline.svg',
                            width: 20.02,
                            height: 19,
                          ),
                        );
                      }),
                    ),
                  ),

                  SizedBox(height: containerHeight * 0.05),

                  // Display feedback text if provided
                  if (feedbackText.isNotEmpty)
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(containerWidth * 0.03),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          feedbackText,
                          style: TextStyle(
                            fontSize: containerWidth * 0.035,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: containerHeight * 0.04),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      postedTime,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
