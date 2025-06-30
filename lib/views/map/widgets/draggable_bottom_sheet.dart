import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/core/widgets/height_box.dart';
import 'package:avatar/models/map/doctor_model.dart';
import 'package:avatar/viewModels/map/mao_view_data_controller.dart';
import 'package:avatar/widgets/cards/category_card.dart';
import 'package:avatar/views/hospital/Widgets/selectable_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final MapViewDataController mapViewDataController = MapViewDataController();

class DraggableBottomSheet extends StatelessWidget {
  const DraggableBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DraggableScrollableSheet(
          initialChildSize: 95 / constraints.maxHeight, // 10% of screen height
          minChildSize: 95 / constraints.maxHeight,
          maxChildSize: 0.90, // 95% of screen height
          snap: true,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Color(0xFFf1f1f1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
              ),
              child: ListView(
                controller: scrollController,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                children: [
                  HeightBox(15),
                  // Indicator divider [for indicating it is slidable]
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const HeightBox(10),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back),
                      ),
                      Flexible(
                        child: SearchBar(
                          elevation: WidgetStatePropertyAll(0),
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                          hintText: 'Search by name, location',
                          leading: Icon(Icons.search),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const HeightBox(15),
                  Material(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: Colors.white,
                    elevation: 0,
                    child: Row(
                      children: List.generate(4, (index) {
                        return SelectableChip(
                          mapViewDataController: mapViewDataController,
                          index: index,
                        );
                      }),
                    ),
                  ),
                  const HeightBox(5),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                        ),
                        label: AppText.body('Saved', fontSize: 16),
                        icon: Icon(
                          Icons.bookmark_outline,
                          size: 28,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: AppText.body(
                          'See All',
                          fontWeight: FontWeight.w500,
                          color: context.theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  HeightBox(10),
                  Center(
                    child: Obx(() {
                      if (mapViewDataController.selectedLabel.value != '') {
                        var doctorData = Doctor.fromJsonList(dummyDoctorJson);
                        return Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              ...List.generate(doctorData.length, (index) {
                                var doctor = doctorData[index];
                                return CategoryCard(
                                  name: doctor.doctorName,
                                  rating: doctor.rating,
                                  reviewCount: doctor.reviews,
                                  address: "${doctor.city} ${doctor.state}",
                                  phone: doctor.phoneNumber.toString(),
                                  showDivider: index != doctorData.length - 1,
                                );
                              }),
                            ],
                          ),
                        );
                      } else {
                        return AppText('No data selected');
                      }
                    }),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
