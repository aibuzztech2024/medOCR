import 'package:avatar/views/advertiser/donate/donation_pdf_generator_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:avatar/views/advertiser/donate/donation_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class DonationDetailController extends GetxController {
  final DonationModel donation;

  DonationDetailController({required this.donation});

  // Loading state for PDF generation
  final RxBool isGeneratingPdf = false.obs;

  /// Check and request storage permissions
  Future<bool> _checkAndRequestPermissions() async {
    if (!Platform.isAndroid) return true;

    if (await Permission.storage.request().isGranted) {
      return true;
    }

    if (await Permission.manageExternalStorage.request().isGranted) {
      return true;
    }

    Get.snackbar(
      'Permission Required',
      'Storage permission is required to save PDF files',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
    return false;
  }

  /// Handle PDF download button press
  Future<void> handlePdfDownload() async {
    try {
      if (!await _checkAndRequestPermissions()) return;

      isGeneratingPdf.value = true;

      await PdfGenerationService.generateAndProcessPdf(
        donation,
        saveToDevice: true,
        shareDirectly: false,
      );

      Get.snackbar(
        'Success',
        'PDF downloaded successfully to Downloads folder',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      _showErrorDialog('Failed to download PDF: ${e.toString()}');
    } finally {
      isGeneratingPdf.value = false;
    }
  }

  /// Handle PDF share button press
  Future<void> handlePdfShare() async {
    try {
      isGeneratingPdf.value = true;

      await PdfGenerationService.generateAndProcessPdf(
        donation,
        saveToDevice: false,
        shareDirectly: true,
      );
    } catch (e) {
      _showErrorDialog('Failed to share PDF: ${e.toString()}');
    } finally {
      isGeneratingPdf.value = false;
    }
  }

  /// Format DateTime string for display
  String formatDateTime(String dateTime) {
    try {
      if (dateTime.contains('AM') || dateTime.contains('PM')) {
        return dateTime;
      }

      final DateTime parsed = DateTime.parse(dateTime);
      final String formattedDate =
          '${parsed.day} ${_getMonthName(parsed.month)} ${parsed.year}';
      final String formattedTime =
          '${parsed.hour > 12 ? parsed.hour - 12 : (parsed.hour == 0 ? 12 : parsed.hour)}:${parsed.minute.toString().padLeft(2, '0')} ${parsed.hour >= 12 ? 'PM' : 'AM'}';
      return '$formattedDate, $formattedTime';
    } catch (e) {
      return dateTime;
    }
  }

  /// Get status display properties
  Map<String, dynamic> getStatusProperties(String status) {
    Color backgroundColor;
    Color textColor;
    String displayStatus = status;

    if (status.toLowerCase() == 'completed') {
      displayStatus = 'Successful';
    }

    switch (status.toLowerCase()) {
      case 'completed':
      case 'successful':
        backgroundColor = const Color(0xFFE8F5E8);
        textColor = const Color(0xFF2E7D32);
        break;
      case 'pending':
        backgroundColor = const Color(0xFFFFF3E0);
        textColor = const Color(0xFFF57C00);
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade700;
    }

    return {
      'displayStatus': displayStatus,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
    };
  }

  /// Show error dialog
  void _showErrorDialog(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  /// Get month name abbreviation
  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
