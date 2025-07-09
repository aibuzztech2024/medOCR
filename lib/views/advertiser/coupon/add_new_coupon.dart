import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/core/widgets/custom_tab_bar.dart';
import 'package:avatar/views/advertiser/coupon/coupon_history.dart';
import 'package:avatar/views/advertiser/coupon/widgets/coupon_code.dart';
import 'package:avatar/views/advertiser/coupon/widgets/labeled_textfield.dart';
import 'package:avatar/views/advertiser/coupon/widgets/upload_creatives.dart';
import 'package:avatar/models/coupon/coupon_model.dart';
import 'package:avatar/viewModels/advertiser/coupon/add_new_coupon_view_model.dart';
import 'package:flutter/material.dart';

class CouponScreen extends StatefulWidget {
  @override
  _CouponScreenState createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late AddNewCouponViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _viewModel = AddNewCouponViewModel();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTabBarWithAppBar(
      title: 'Coupon',
      subtitle:
          'Expand your reach with exclusive coupons for a\ntargeted audience!',
      tabController: _tabController,
      tabTitles: ['Add New Coupon', 'Coupon History'],
      tabViews: [
        // Add New Coupon Tab Content
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'Coupon Details',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF6F61),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 111, 97, 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabeledTextField(
                        label: 'Coupon Title',
                        controller: _viewModel.titleController,
                        hintText: 'Eg. Summer mega offer',
                      ),
                      AppText(
                        "*Title exists limit of 80 character's",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Description',
                        controller: _viewModel.descriptionController,
                        hintText: 'Eg. Summer mega offer',
                      ),
                      AppText(
                        "*Description exists limit of 100 character's",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Coupon Code',
                        controller: _viewModel.codeController,
                        hintText: 'Eg. SUMMER10',
                      ),
                    ],
                  ),
                ),
                AppText(
                  'Target Audience',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF6F61),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 111, 97, 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LabeledTextField(
                        label: 'Country',
                        controller: _viewModel.countryController,
                        hintText: 'Eg. Summer mega offer',
                      ),
                      AppText(
                        "*Title exists limit of 100 character's",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      LabeledTextFieldRow(
                        firstField: LabeledTextField(
                          label: 'State',
                          controller: _viewModel.stateController,
                          hintText: 'Maharashtra',
                          suffixDropdown: true,
                        ),
                        secondField: LabeledTextField(
                          label: 'City',
                          controller: _viewModel.cityController,
                          hintText: 'Pune',
                          suffixDropdown: true,
                        ),
                      ),
                      LabeledTextFieldRow(
                        firstField: LabeledTextField(
                          label: 'Age',
                          controller: _viewModel.ageController,
                          suffixDropdown: true,
                        ),
                        secondField: LabeledTextField(
                          label: 'Gender',
                          controller: _viewModel.genderController,
                          hintText: 'Male',
                          suffixDropdown: true,
                        ),
                      ),
                      LabeledTextFieldRow(
                        firstField: LabeledTextField(
                          label: 'Spending Power',
                          controller: _viewModel.spendingPowerController,
                          hintText: 'One Time',
                          suffixDropdown: true,
                        ),
                        secondField: LabeledTextField(
                          label: 'Offer Type',
                          controller: _viewModel.offerTypeController,
                          hintText: 'Fixed Amount',
                          suffixDropdown: true,
                        ),
                      ),
                      LabeledTextFieldRow(
                        firstField: LabeledTextField(
                          label: 'Maximum Redemption',
                          controller: _viewModel.maxRedemptionController,
                          suffixDropdown: true,
                        ),
                        secondField: LabeledTextField(
                          label: '*Validity',
                          controller: _viewModel.validityController,
                          hintText: 'DD/MM/YY',
                          suffixCalendar: true,
                          onCalendarTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                AppText(
                  'Add Creatives',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF6F61),
                  ),
                ),
                UploadCreativesWidget(
                  showVirusScan: true,
                  onUploadTap: () {},
                  onVirusScanTap: () {},
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      type: ButtonType.outlined,
                      text: 'Cancel',
                      onPressed: () {},
                      color: Colors.black,
                      width: 173,
                      borderRadius: 6,
                    ),
                    SizedBox(width: 16),
                    AppButton(
                      type: ButtonType.filled,
                      text: 'Post',
                      onPressed: () {},
                      color: Color(0xFFFF6F61),
                      width: 173,
                      borderRadius: 6,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        // Coupon History Tab Content
        CouponHistory(),
      ],
    );
  }
}
