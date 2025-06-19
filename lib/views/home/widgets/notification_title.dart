import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// MODEL ///
class NotificationModel {
  final String timeAgo;
  final String message;

  NotificationModel({
    required this.timeAgo,
    required this.message,
  });
}

/// VIEWMODEL ///
class NotificationViewModel extends GetxController {
  final notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.value = [
      NotificationModel(
        timeAgo: '5 mins ago',
        message: 'You have earned 50 credit points through referral',
      ),
    ];
  }
}

/// MAIN WIDGET ///
class NotificationTitle extends StatelessWidget {
  const NotificationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(NotificationViewModel());

    return Center(
      child: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 78), // adjust as per requirement
          itemCount: viewModel.notifications.length,
          itemBuilder: (context, index) {
            final notification = viewModel.notifications[index];
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFEFAF3),  // Background color inside notification
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color(0xFFE8E8E8), // Border color #E8E8E8
                  width: 0.5,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Bell Icon inside orange circle
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Notification Text Content (time + message)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            // Green dot
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),

                            // Time ago text
                            Text(
                              notification.timeAgo,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                height: 1.0,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification.message,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            height: 1.0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
