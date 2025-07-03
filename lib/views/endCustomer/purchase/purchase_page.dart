import 'package:avatar/views/endCustomer/purchase/searchTab_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../viewModels/endCustomer/purchase/search_controller.dart';
import '../../pharmacy/Pages/full_order_history.dart';
import '../../pharmacy/Pages/order_discussions.dart';
import '../../purchase/widgets/submit_requests.dart';

///---- TO DO  change color all----------------
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(searchTabController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Purchase',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              'Buy Better, Save More & Simplify Procurement',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            dividerHeight: 0.0,
            isScrollable: true,
            controller: _tabController,
            labelColor: Colors.orange,
            indicatorColor: Colors.orange,

            tabAlignment: TabAlignment.start,
            tabs: const [
              Tab(text: "Search"),
              Tab(text: "Submit Request"),
              Tab(text: "Order Discussion"),
              Tab(text: "Order History"),

            ],
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,

              children: [
                searchTab_view(),
                SubmitRequest(),
                OrderDiscussions(),
                FullOrderHistory(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
