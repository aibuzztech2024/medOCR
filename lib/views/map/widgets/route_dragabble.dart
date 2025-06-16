import 'package:avatar/models/map/route_dragabble.dart';
import 'package:avatar/viewModels/map/route_dragabble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RouteDraggable extends StatelessWidget {
  const RouteDraggable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Draggable Bottom Sheet')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => DraggableContent(),
            );
          },
          child: const Text('Open Sheet'),
        ),
      ),
    );
  }
}

class DraggableContent extends StatelessWidget {
  DraggableContent({super.key});

  final controller = Get.find<RouteDraggableController>();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                // this image is not showing on the ui screen. so i use png instead of svg.
                // child: SvgPicture.asset(
                //   'assets/images/map/hotel.svg',
                //   width: double.infinity,
                //   height: 150,
                //   fit: BoxFit.cover,
                // ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, right: 14, left: 14),
                  child: Image.asset(
                    'assets/images/map/hotel.png',
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Central Command',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'General Hospital',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.bookmark_border,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              DefaultTabController(
                length: 4,
                child: Expanded(
                  child: Column(
                    children: [
                      TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: Colors.amber,
                        labelColor: Colors.amber,
                        unselectedLabelColor: Colors.black,
                        tabs: const [
                          Tab(icon: Icon(Icons.directions)),
                          Tab(icon: Icon(Icons.directions_car_outlined)),
                          Tab(icon: Icon(Icons.pedal_bike)),
                          Tab(icon: Icon(Icons.directions_walk)),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildTabContent(scrollController),
                            const Center(child: Text('Tab 2')),
                            const Center(child: Text('Tab 3')),
                            const Center(child: Text('Tab 4')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabContent(ScrollController scrollController) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '12 min ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                            ),
                          ),
                          TextSpan(
                            text: '(6.7 km)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Default color
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 4),
                    Text(
                      'Fastest route',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  'Earn 2.8 Credit points on \nthis ride completion.',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(width: 8),
              Image.asset(
                'assets/images/map/dollar.png',
                width: 20,
                height: 20,
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
                color: isSelected ? Colors.amber.shade50 : Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                border: Border(
                  left: BorderSide(
                    color: isSelected ? Colors.amber : Colors.transparent,
                    width: 4,
                  ),
                  top: BorderSide(
                    color: isSelected ? Colors.amber : Colors.transparent,
                    width: 1,
                  ),
                  right: BorderSide(
                    color: isSelected ? Colors.amber : Colors.transparent,
                    width: 1,
                  ),
                  bottom: BorderSide(
                    color: isSelected ? Colors.amber : Colors.transparent,
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
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          item.duration,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.amber,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          item.distance,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.share_outlined),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.amber, Colors.amberAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: InkWell(
                        onTap: () {
                          // Handle GO action
                        },
                        borderRadius: BorderRadius.circular(6),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'GO',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward,
                                size: 14,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     // Handle GO action
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Text('GO'),
                    //       Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                onTap: () {
                  controller.selectIndex(index);
                  print('Container selected: ${item.title}');
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
