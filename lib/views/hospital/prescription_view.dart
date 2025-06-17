import 'dart:io';
import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../viewModels/hospital/image_prescription_controller.dart';
import '../map/widgets/upload_issue_image.dart';

class PrescriptionView extends StatelessWidget {
  final PrescriptionController controller = Get.put(PrescriptionController());

  PrescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = controller.prescriptions;

      return UploadIssueImage(controller: controller);
    });
  }
}
