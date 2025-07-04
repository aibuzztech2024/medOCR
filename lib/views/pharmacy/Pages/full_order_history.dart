import 'package:avatar/views/pharmacy/widgets/transaction_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// ViewModel using GetX
class SearchExportViewModel extends GetxController {
  final RxString selectedOption = "Select".obs;

  void changeOption(String newOption) {
    selectedOption.value = newOption;
  }
}

/// Main UI View
class FullOrderHistory extends StatelessWidget {
  FullOrderHistory({super.key});

  // Put controllers once, so not recreated every build
  final SearchExportViewModel vm = Get.put(SearchExportViewModel());

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;
    const primaryColor = Color(0xFF1BA5A6);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.01,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(width),
              SizedBox(height: height * 0.02),
              _buildButtonsRow(primaryColor),
              SizedBox(height: height * 0.02),
               TransactionHistory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(double width) {
    return Container(
      constraints: const BoxConstraints(minHeight: 48),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: width * 0.035),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/search.svg",
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              Colors.black54,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                primaryColor: Colors.transparent, // removes green glow
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: Colors.transparent, // removes green focus border
                ),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search by medicine name or categories",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  isDense: true,
                ),
                cursorColor: Colors.black,
                style: TextStyle(fontSize: width * 0.03),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildButtonsRow(Color primaryColor) {
    return Row(
      children: [
        Obx(() => SizedBox(
          width: 107,
          height: 42,
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: Add select option logic
            },
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: primaryColor,
              size: 20,
            ),
            label: Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                vm.selectedOption.value,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: primaryColor, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        )),
        const SizedBox(width: 12),
        SizedBox(
          width: 107,
          height: 42,
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: Add export functionality
            },
            icon: Icon(
              Icons.upload_file_outlined,
              color: primaryColor,
              size: 20,
            ),
            label: Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                "Export",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: primaryColor, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }
}
