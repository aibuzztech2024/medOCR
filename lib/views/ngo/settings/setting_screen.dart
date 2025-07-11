
import 'package:avatar/core/constants/appColors.dart';
import 'package:avatar/views/pharmacy_app/purchase/order_discussion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'account_settings_view.dart';
import 'organizer_details_view.dart';


///---- TO DO  change color all----------------
class Setting_Screen extends StatefulWidget {
  const Setting_Screen({super.key});

  @override
  State<Setting_Screen> createState() => _ProductPageState();
}

class _ProductPageState extends State<Setting_Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.edit_outlined ,color: Colors.black,))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            dividerHeight: 0.0,
            isScrollable: true,
            controller: _tabController,
            labelColor: AppColors.ngo_primary,
            indicatorColor: AppColors.ngo_primary,

            tabAlignment: TabAlignment.start,
            tabs: const [
              Tab(text: "Account Details"),
              Tab(text: "Notification Center"),

            ],
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,

              children: [
                AccountInfoScreen(),
                OrganizerDetailsView(),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
