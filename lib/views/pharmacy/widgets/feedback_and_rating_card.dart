import 'package:avatar/views/pharmacy/widgets/feedback_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedbackController extends GetxController {
  final RxInt selectedRating = 0.obs;
  final RxString feedbackText = ''.obs;
  final TextEditingController textController = TextEditingController();

  // Add variables to track submitted feedback
  final RxBool hasSubmittedFeedback = false.obs;
  final RxInt submittedRating = 0.obs;
  final RxString submittedFeedbackText = ''.obs;
  final RxString submittedTime = ''.obs; // Store the time at submission

  String get currentTime {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  void setRating(int rating) {
    selectedRating.value = rating;
  }

  void updateFeedbackText(String text) {
    feedbackText.value = text;
  }

  void submitFeedback() {
    if (selectedRating.value > 0 || feedbackText.value.isNotEmpty) {
      // Store submitted feedback data
      submittedRating.value = selectedRating.value;
      submittedFeedbackText.value = feedbackText.value;
      submittedTime.value = currentTime; // Store the time at submission
      hasSubmittedFeedback.value = true;
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}

class FeedbackRatingWidget extends StatelessWidget {
  const FeedbackRatingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeedbackController());

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive dimensions
        final containerWidth =
            constraints.maxWidth > 400 ? 366.0 : constraints.maxWidth * 0.9;
        final containerHeight =
            constraints.maxHeight > 300 ? 261.0 : constraints.maxHeight * 0.85;

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
                vertical: containerHeight * 0.02,
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Center(
                    child: Text(
                      'Give your ratings and feedback.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: containerHeight * 0.02),

                  // Star Rating
                  Center(
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final starIndex = index + 1;
                          final isSelected =
                              starIndex <= controller.selectedRating.value;

                          return GestureDetector(
                            onTap: () => controller.setRating(starIndex),
                            child: Padding(
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
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

                  SizedBox(height: containerHeight * 0.04),

                  // Feedback Text Field
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.textController,
                              onChanged: controller.updateFeedbackText,
                              maxLines: null,
                              expands: true,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: InputDecoration(
                                hintText: 'Add your Feedback',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: containerWidth * 0.04,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.all(
                                  containerWidth * 0.04,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: containerWidth * 0.04,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          // Submit Button and Time
                          Padding(
                            padding: EdgeInsets.all(containerWidth * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: controller.submitFeedback,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF3AAFA9),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: containerWidth * 0.08,
                                      vertical: containerHeight * 0.04,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: containerWidth * 0.038,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: containerHeight * 0.04),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      controller.currentTime,
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

// Combined widget that shows both FeedbackRatingWidget and conditionally shows FeedbackWidget
class FeedbackSection extends StatelessWidget {
  const FeedbackSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeedbackController());

    return Column(
      children: [
        FeedbackRatingWidget(),
        Obx(() {
          // Show FeedbackWidget only if feedback has been submitted
          if (controller.hasSubmittedFeedback.value) {
            return Column(
              children: [
                const SizedBox(height: 12),
                FeedbackWidget(
                  rating: controller.submittedRating.value,
                  feedbackText: controller.submittedFeedbackText.value,
                  postedTime:
                      controller.submittedTime.value, // Use the stored time
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
