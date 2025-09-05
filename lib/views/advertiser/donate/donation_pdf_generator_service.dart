import 'dart:io';
import 'dart:typed_data';
import 'package:avatar/views/advertiser/donate/donation_pdf_layout.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:avatar/views/advertiser/donate/donation_model.dart';
import 'package:path/path.dart' as path;

class PdfGenerationService {
  /// Generate PDF bytes for donation details
  static Future<Uint8List> generateDonationPdf(DonationModel donation) async {
    try {
      // Load image if available
      final imageProvider = await loadImage(donation.imageUrl);

      // Build PDF document using layout builder
      final pdf = PdfLayoutBuilder.buildDonationPdf(donation, imageProvider);

      // Return PDF bytes
      return await pdf.save();
    } catch (e) {
      debugPrint('Error generating PDF: $e');
      rethrow;
    }
  }

  /// Share PDF directly
  static Future<void> sharePdf(Uint8List pdfBytes, String filename) async {
    try {
      await Printing.sharePdf(bytes: pdfBytes, filename: filename);
    } catch (e) {
      debugPrint('Error sharing PDF: $e');
      rethrow;
    }
  }

  /// Save PDF to device storage
  static Future<void> savePdf(Uint8List pdfBytes, String filename) async {
    try {
      Directory? directory;

      if (Platform.isAndroid) {
        // For Android, save to Downloads folder
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else {
        // For other platforms, use the default documents directory
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not access storage directory');
      }

      final file = File(path.join(directory.path, filename));
      await file.writeAsBytes(pdfBytes);
      debugPrint('PDF saved to: ${file.path}');
    } catch (e) {
      debugPrint('Error saving PDF to device: $e');
      rethrow;
    }
  }

  /// Load image from URL
  static Future<pw.ImageProvider?> loadImage(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) return null;

    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return pw.MemoryImage(response.bodyBytes);
      }
    } catch (e) {
      debugPrint('Error loading image: $e');
    }
    return null;
  }

  /// Generate filename for PDF
  static String generateFilename(String title) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'donationdetails_${title.replaceAll(' ', '_')}_$timestamp.pdf';
  }

  /// Complete PDF generation with options
  static Future<void> generateAndProcessPdf(
    DonationModel donation, {
    bool saveToDevice = true,
    bool shareDirectly = true,
  }) async {
    try {
      // Generate PDF bytes
      final pdfBytes = await generateDonationPdf(donation);
      final filename = generateFilename(donation.title);

      // Process based on options
      if (shareDirectly) {
        await sharePdf(pdfBytes, filename);
      }

      if (saveToDevice) {
        await savePdf(pdfBytes, filename);
      }
    } catch (e) {
      debugPrint('Error in PDF generation process: $e');
      rethrow;
    }
  }

  /// Format DateTime to readable string
  static String formatDateTime(DateTime dateTime) {
    final day = dateTime.day;
    final month = _getMonthName(dateTime.month);
    final year = dateTime.year;
    final hour =
        dateTime.hour > 12
            ? dateTime.hour - 12
            : (dateTime.hour == 0 ? 12 : dateTime.hour);
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$day $month $year, $hour:$minute $period';
  }

  /// Get month name abbreviation
  static String _getMonthName(int month) {
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
