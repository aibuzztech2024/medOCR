// pdf_download_button.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfDownloadButton extends StatelessWidget {
  final Future<pw.Document> Function() onGeneratePdf;
  final String fileName;
  final String snackBarSuccessMessage;
  final String snackBarErrorMessage;

  const PdfDownloadButton({
    super.key,
    required this.onGeneratePdf,
    this.fileName = 'document.pdf',
    this.snackBarSuccessMessage = 'PDF saved successfully',
    this.snackBarErrorMessage = 'PDF generation failed',
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.download),
      tooltip: 'Download as PDF',
      onPressed: () async {
        try {
          // Show loading indicator
          Get.dialog(
            const Center(
              child: CircularProgressIndicator(),
            ),
            barrierDismissible: false,
          );

          // Generate PDF from widget tree
          final pw.Document pdf = await onGeneratePdf();
          
          // Close loading dialog
          Get.back();

          // TODO: Add option to save to device storage
          // TODO: Add option to share via email/messaging apps
          // TODO: Add print preview functionality
          
          // Use printing package to save or share PDF
          await Printing.layoutPdf(
            onLayout: (PdfPageFormat format) async => pdf.save(),
            name: fileName,
          );

          Get.snackbar(
            "Success", 
            snackBarSuccessMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } catch (e) {
          // Close loading dialog if still open
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          
          print('PDF generation failed: $e');
          Get.snackbar(
            "Error", 
            snackBarErrorMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          
          // TODO: Add detailed error logging
          // TODO: Add user-friendly error messages based on error type
        }
      },
    );
  }
}

// TODO: Create a separate PDF service class for better organization
// TODO: Add PDF template customization options
// TODO: Add support for multiple pages if content is large
// TODO: Add watermark functionality
// TODO: Add digital signature support
// TODO: Implement PDF compression options
// TODO: Add accessibility features to PDF
// TODO: Create unit tests for PDF generation
// TODO: Add internationalization support for different languages