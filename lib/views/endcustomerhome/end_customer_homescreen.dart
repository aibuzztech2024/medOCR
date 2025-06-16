import 'package:avatar/viewModels/endcustomerhome/controller/chart_controller.dart';
import 'package:avatar/viewModels/endcustomerhome/controller/end_customer_appbar_controller.dart';
import 'package:avatar/core/widgets/endcustomer_appbar.dart';
import 'package:avatar/views/endcustomerhome/widget/feature_reward_widget.dart';
import 'package:avatar/views/endcustomerhome/widget/multi_line_chart_widget.dart';
import 'package:avatar/views/endcustomerhome/widget/overview_widget.dart';
import 'package:avatar/views/endcustomerhome/widget/upcoming_events_widget.dart';
import 'package:avatar/widgets/cards/referral_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EndCustomerHomescreen extends StatelessWidget {
  const EndCustomerHomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EndCustomerAppbarController());
    final ChartController controller = Get.put(ChartController());

    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),

      ///TODO change accoring to req
      body: Obx(() {
        if (controller.isLoading) {
          // Show loading indicator while data is being fetched
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              EndcustomerAppbar(),
              ReferralCardWidget(),
              OverviewWidget(),
              const SizedBox(height: 20),
              MultiLineChartWidget(series: controller.chartSeries),
              const SizedBox(height: 20),
              UpcomingEventsWidget(),
              const SizedBox(height: 20),

              // widget for scrollable coupons list for homepage
              const FeatureRewardsWidget(),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
