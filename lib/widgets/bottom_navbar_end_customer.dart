import 'package:avatar/core/constants/icons_paths.dart';
import 'package:avatar/core/constants/image_paths.dart';
import 'package:avatar/models/navigation/bottom_nav_item_model.dart';
import 'package:avatar/models/navigation/segment_tab_model.dart';
import 'package:avatar/views/endcustomer/end_customer_homescreen.dart';
import 'package:avatar/views/endcustomer/purchase/purchase_page.dart';
import 'package:avatar/views/hospital/Widgets/hospital_place_list.dart';
import 'package:avatar/views/hospital/Widgets/prescription_view.dart';
import 'package:avatar/views/map/map_scree_view.dart';
import 'package:avatar/views/navigation/bottom_nav_bar.dart';
import 'package:avatar/views/points/points_tabbar_container.dart';
import 'package:avatar/views/share/home.dart';
import 'package:flutter/material.dart';

// Bottombar for EndCustomer

class BottomNavbarEndCustomer extends StatelessWidget {
  const BottomNavbarEndCustomer({super.key});

// This widget displays bottomnavigationbar with provided items
  @override
  Widget build(BuildContext context) {
    // Define segment tabs data with content widgets
    final List<SegmentTabModel> tabs = [
      SegmentTabModel(
        label: 'Prescription',
        iconSvgPath: "assets/icons/medical-prescription_svgrepo.com.svg",
        activeColor: Colors.orange,
        child: Center(child: Text('Prescription View')),
      ),
      SegmentTabModel(
        label: 'Bills',
        iconSvgPath: "assets/icons/document-text_svgrepo.com.svg",
        activeColor: Colors.orange,
        child: PrescriptionView(), 
      ),
      SegmentTabModel(
        label: 'Medicine',
        iconSvgPath: "assets/icons/medicine-pills-tablets_svgrepo.com.svg",
        activeColor: Colors.orange,
        child: HospitalPlaceList(), 
      ),
    ];

    // Define navigation items for BottomNavBar
    final navItems = [
      BottomNavItemModel(
        icon: IconsPaths.home,
        title: "Home",
        screen: Center(child: EndCustomerHomescreen()), 
      ),
      BottomNavItemModel(
        icon: IconsPaths.mapSearch,
        title: "Map",
        screen: MapScree(),
        // PerfectSegmentToggleWidget(tabs: tabs),
      ),
      BottomNavItemModel(
        icon: IconsPaths.upload,
        title: "Purchase",
        screen: Center(child: ProductPage()), 
      ),
      BottomNavItemModel(
        icon: IconsPaths.purchase,
        title: "Share",
        screen: Center(child: ShareHome()), 
      ),
      BottomNavItemModel(
        icon: IconsPaths.home,
        // Using home icon as a placeholder
        title: "Points",
        screen: Center(child: PointsTabbarContainer()), 
        isCustomIcon: true,
        customIcon: CircleAvatar(
          radius: 14,
          backgroundImage: AssetImage(ImagePaths.profileImage),
        ),
      ),
    ];

    return BottomNavBar(navItems: navItems);
  }
}

