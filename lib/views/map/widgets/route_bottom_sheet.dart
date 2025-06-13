import 'package:flutter/material.dart';

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
              builder: (_) => const DraggableContent(),
            );
          },
          child: const Text('Open Sheet'),
        ),
      ),
    );
  }
}

class DraggableContent extends StatelessWidget {
  const DraggableContent({super.key});

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
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // IMAGE
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  'https://via.placeholder.com/400x150',
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),

              // TITLE + SUBTITLE + ICONS
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
                            'Title Goes Here',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Subtitle here',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      onPressed: () {},
                    ),
                    IconButton(icon: const Icon(Icons.share), onPressed: () {}),
                  ],
                ),
              ),

              // TAB BAR
              DefaultTabController(
                length: 4,
                child: Expanded(
                  child: Column(
                    children: [
                      const TabBar(
                        indicatorColor: Colors.orange,
                        tabs: [
                          Tab(icon: Icon(Icons.info)),
                          Tab(icon: Icon(Icons.star)),
                          Tab(icon: Icon(Icons.comment)),
                          Tab(icon: Icon(Icons.settings)),
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

  Widget _buildTabContent(ScrollController controller) {
    final dynamicList = ['Item 1', 'Item 2', 'Item 3'];
    return ListView(
      controller: controller,
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Section Title',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text('Section subtitle', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        const Text('This is a sentence corresponding to the section.'),
        const SizedBox(height: 16),
        ...dynamicList.map(
          (item) => ListTile(
            leading: const Icon(Icons.circle),
            title: Text(item),
            subtitle: const Text('Subtitle for item'),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
