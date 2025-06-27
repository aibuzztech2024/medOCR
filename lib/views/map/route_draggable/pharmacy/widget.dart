import 'package:avatar/models/map/route_draggable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget pharmacyBuildTabContent(ScrollController scrollController, controller) {
  return Obx(
    () => ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.selectedIndex.value >= 0 &&
                        controller.selectedIndex.value <
                            controller.options.length)
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${controller.options[controller.selectedIndex.value].duration} ',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3AAFA9),
                              ),
                            ),
                            TextSpan(
                              text:
                                  '(${controller.options[controller.selectedIndex.value].distance})',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF191919),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Text(
                      controller
                          .options[controller.selectedIndex.value]
                          .description,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFEDFFFE),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF191919),
                        ),
                        children: [
                          const TextSpan(text: 'Earn '),
                          TextSpan(
                            text:
                                '${controller.options[controller.selectedIndex.value].creditpoint} ',
                            style: const TextStyle(
                              color: Color(0xFF3AAFA9),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: 'Credit points on \nthis ride completion.',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),
                    Image.asset(
                      'assets/images/map/dollar.png',
                      width: 18,
                      height: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...controller.options.asMap().entries.map((entry) {
          int index = entry.key;
          RouteOption item = entry.value;
          bool isSelected = index == controller.selectedIndex.value;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFFEDFFFE) : Color(0xFFF7F8FC),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border(
                left: BorderSide(
                  color: isSelected ? Color(0xFF3AAFA9) : Colors.transparent,
                  width: 4,
                ),
                top: BorderSide(
                  color: isSelected ? Color(0xFF3AAFA9) : Colors.transparent,
                  width: 1,
                ),
                right: BorderSide(
                  color: isSelected ? Color(0xFF3AAFA9) : Colors.transparent,
                  width: 1,
                ),
                bottom: BorderSide(
                  color: isSelected ? Color(0xFF3AAFA9): Colors.transparent,
                  width: 1,
                ),
              ),
            ),
            child: ListTile(
              title: Text(
                item.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF929292),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        item.duration,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color(0xFF3AAFA9),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.distance,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color(0xFF929292),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor:
                        isSelected ? Color(0xFFF7F8FC) : Colors.white,
                    child: const Icon(Icons.share_outlined),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFCDFFFC), Color(0xFF3AAFA9)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 80,
                    ), //  increase min width
                    child: InkWell(
                      onTap: () {
                        // Handle GO action
                      },
                      // borderRadius: BorderRadius.circular(6),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              12, // slightly more horizontal padding if needed
                          vertical: 6,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Go',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                controller.selectIndex(index);
              },
            ),
          );
        }).toList(),
      ],
    ),
  );
}
