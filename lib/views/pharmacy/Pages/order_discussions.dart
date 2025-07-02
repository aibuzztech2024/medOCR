import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../widgets/chat_list_widget.dart'; // make sure this path is correct

/// ----------------------------
/// Model class for communication item
class CommunicationModel {
  final String title;
  final int unreadCount;
  final String iconPath;

  CommunicationModel({
    required this.title,
    required this.unreadCount,
    required this.iconPath,
  });
}

/// ----------------------------
/// ViewModel using GetX
class CommunicationViewModel extends GetxController {
  final Rx<CommunicationModel> communication = CommunicationModel(
    title: "Communications",
    unreadCount: 4,
    iconPath: "assets/icons/swap.svg", // Placeholder icon
  ).obs;

  void markAllRead() {
    communication.value = CommunicationModel(
      title: communication.value.title,
      unreadCount: 0,
      iconPath: communication.value.iconPath,
    );
  }
}

/// ----------------------------
/// Main UI View
class OrderDiscussions extends StatelessWidget {
  final CommunicationViewModel vm = Get.put(CommunicationViewModel());

  OrderDiscussions({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = Get.width;
    final double height = Get.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Search Box
                Container(
                  constraints: const BoxConstraints(minHeight: 48),
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/search.svg",
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Search by medicine name or categories",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: width * 0.035),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.03),

                /// Communication Card + Chat List
                Obx(() {
                  final item = vm.communication.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => vm.markAllRead(),
                        child: Container(
                          width: width,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.03, vertical: height * 0.006),
                          decoration: BoxDecoration(
                            color: const Color(0xFF35A6A6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              /// Left Text
                              Expanded(
                                child: Text(
                                  "${item.title} ${item.unreadCount > 0 ? "(${item.unreadCount} Unread)" : ""}",
                                  style: TextStyle(
                                    fontSize: width * 0.04,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              /// Right Icon
                              Container(
                                width: width * 0.09,
                                height: width * 0.09,
                                padding: EdgeInsets.all(width * 0.02),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: SvgPicture.asset(
                                  item.iconPath,
                                  colorFilter:
                                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.02),

                      /// Chat List Widget (no scaffold inside)
                      ChatListWidget(),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
