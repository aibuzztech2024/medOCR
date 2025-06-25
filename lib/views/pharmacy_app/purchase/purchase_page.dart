import 'package:avatar/core/constants/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:avatar/core/constants/appColors.dart';
import 'package:avatar/models/pharmacy_app/purchase/productModal.dart';
import 'package:avatar/views/pharmacy_app/purchase/purchase_page.dart';
import 'package:avatar/views/pharmacy_app/purchase/searchTab_view.dart';
import 'package:avatar/views/pharmacy_app/purchase/widgets/dropdownfield.dart';
import 'package:avatar/views/pharmacy_app/purchase/widgets/product_card.dart';
import 'package:avatar/viewModels/pharmacy_app/purchase/search_controller.dart';

///---- TO DO  change color all----------------
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with SingleTickerProviderStateMixin {
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
            Text('Purchase', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            Text('Buy Better, Save More & Simplify Procurement', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
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
            labelColor: AppColors.pharmacy_PrimaryColor,
            indicatorColor: AppColors.pharmacy_PrimaryColor,

            tabAlignment: TabAlignment.start,
            tabs: const [
              Tab(text: "Search"),
              Tab(text: "Submit Request"),
              Tab(text: "Order Discussion"),
              Tab(text: "Submit Request"),
              Tab(text: "Order Discussion"),
              Tab(text: "Submit Request"),
              Tab(text: "Order Discussion"),
            ],
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,

              children: [
                searchTab_view(),
                Center(child: Text("Submit Request")),
                Center(child: Text("Order Discussion")),
                Center(child: Text("Submit Request")),
                Center(child: Text("Order Discussion")),
                Center(child: Text("Submit Request")),
                Center(child: Text("Order Discussion")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
