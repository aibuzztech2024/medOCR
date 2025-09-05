import 'package:flutter/material.dart';

class AddNewCouponViewModel extends ChangeNotifier {
  // Controllers for coupon details
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  // Controllers for target audience
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController spendingPowerController = TextEditingController();
  final TextEditingController offerTypeController = TextEditingController();
  final TextEditingController maxRedemptionController = TextEditingController();
  final TextEditingController validityController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    codeController.dispose();
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    ageController.dispose();
    genderController.dispose();
    spendingPowerController.dispose();
    offerTypeController.dispose();
    maxRedemptionController.dispose();
    validityController.dispose();
    super.dispose();
  }
}
