import 'package:avatar/viewModels/map/route_draggable.dart';
import 'package:avatar/views/map/route_draggable/pharmacy/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PharmacyRouteDraggable extends StatelessWidget {
  const PharmacyRouteDraggable({super.key});

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
              builder: (_) => PharmacyDraggableContent(),
            );
          },
          child: const Text('Open Sheet'),
        ),
      ),
    );
  }
}

class PharmacyDraggableContent extends StatelessWidget {
  PharmacyDraggableContent({super.key});

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
                            style: TextStyle(color: Color(0xFF484848)),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xFFF7F8FC),
                      child: IconButton(
                        icon: const Icon(
                          Icons.bookmark_border,
                          color: Color(0xFF191919),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: Color(0xFFF7F8FC),
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Color(0xFF191919)),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              DefaultTabController(
                length: 4,
                child: Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: Color(0xFF3AAFA9),
                          indicator: BoxDecoration(
                            color: Color(0xFFEDFFFE),
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFF3AAFA9),
                                width: 3,
                              ), // underline
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ), // optional rounded corners
                          ),
                          labelColor: Color(0xFF3AAFA9),
                          unselectedLabelColor: Color(0xFF191919),
                          tabs: const [
                            Tab(icon: Icon(Icons.directions)),
                            Tab(icon: Icon(Icons.directions_car_outlined)),
                            Tab(icon: Icon(Icons.pedal_bike)),
                            Tab(icon: Icon(Icons.directions_walk)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            pharmacyBuildTabContent(
                              scrollController,
                              controller,
                            ),
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
}
