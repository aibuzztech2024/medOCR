import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedbackController extends GetxController {
  final RxInt selectedRating = 0.obs;
  final RxString feedbackText = ''.obs;
  final TextEditingController textController = TextEditingController();

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
      // Handle submission logic here
      Get.snackbar(
        'Success',
        'Thank you for your feedback!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF4ECDC4),
        colorText: Colors.white,
      );

      // Reset form
      selectedRating.value = 0;
      feedbackText.value = '';
      textController.clear();
    } else {
      Get.snackbar(
        'Error',
        'Please provide a rating or feedback',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
                horizontal: containerWidth * 0.04,
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
