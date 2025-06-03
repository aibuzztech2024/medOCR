import 'package:avatar/models/points/transaction_model.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class TransactionController extends GetxController {
  var transaction = Rxn<TransactionModel>();

  @override
  void onInit() {
    super.onInit();
    loadTransaction();
  }

  // TODO: Replace this mock data with real API call
  void loadTransaction() {
    transaction.value = TransactionModel(
      referenceId: 'TXN123456',
      uploadedBy: 'John Doe',
      downloadedOn: DateTime.parse('2025-03-20 10:30:00'),
      status: 'Ongoing',
      fileType: 'Upload',
      rewardPoints: 5000,
      dateTime: DateTime.parse('2025-03-20T10:30:00'),
      imagePath: 'assets/images/transaction.png',
    );
  }

  // TODO: Move this to a utility class for reusability
  String monthName(int month) {
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

  // TODO: Consider using intl package for better date/time formatting
  String formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  // TODO: Add error handling for image loading failures
  // TODO: Add support for different image formats
  // TODO: Consider caching loaded images for better performance
  Future<pw.Document> generatePdf() async {
    final transaction = this.transaction.value;
    if (transaction == null) {
      throw Exception('No transaction data available');
    }

    final pdf = pw.Document();

    // TODO: Load a custom font for better text rendering
    // final font = await PdfGoogleFonts.nunitoRegular();

    // TODO: Handle different image sources (network, asset, file)
    pw.ImageProvider? transactionImage;
    try {
      if (transaction.imagePath.isNotEmpty) {
        if (transaction.imagePath.startsWith('http')) {
          // Network image
          // TODO: Add network image loading with proper error handling
          // final imageBytes = await http.get(Uri.parse(transaction.imagePath));
          // transactionImage = pw.MemoryImage(imageBytes.bodyBytes);
        } else if (transaction.imagePath.startsWith('assets/')) {
          // Asset image
          final ByteData imageData = await rootBundle.load(
            transaction.imagePath,
          );
          transactionImage = pw.MemoryImage(imageData.buffer.asUint8List());
        } else {
          // File image
          final File imageFile = File(transaction.imagePath);
          if (await imageFile.exists()) {
            final Uint8List imageBytes = await imageFile.readAsBytes();
            transactionImage = pw.MemoryImage(imageBytes);
          }
        }
      }
    } catch (e) {
      print('Error loading transaction image: \$e');
      // TODO: Use a placeholder image when main image fails to load
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.only(bottom: 20),
                decoration: const pw.BoxDecoration(
                  border: pw.Border(
                    bottom: pw.BorderSide(color: PdfColors.grey300, width: 1),
                  ),
                ),
                child: pw.Text(
                  'Transaction Details',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ),

              pw.SizedBox(height: 20),

              // Transaction Image
              if (transactionImage != null) ...[
                pw.Container(
                  width: double.infinity,
                  height: 200,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey300),
                    borderRadius: pw.BorderRadius.circular(8),
                  ),
                  child: pw.ClipRRect(
                    child: pw.Image(transactionImage, fit: pw.BoxFit.cover),
                  ),
                ),
                pw.SizedBox(height: 20),
              ],

              // Transaction Details
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey50,
                  borderRadius: pw.BorderRadius.circular(8),
                  border: pw.Border.all(color: PdfColors.grey200),
                ),
                child: pw.Column(
                  children: [
                    buildPdfRow('File Type', transaction.fileType),
                    pw.SizedBox(height: 12),
                    buildPdfRow(
                      'Date & Time',
                      formatDateTime(transaction.dateTime),
                    ),

                    pw.SizedBox(height: 12),
                    buildPdfRow(
                      'Reward Points',
                      transaction.rewardPoints.toString(),
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                          width: 60, // Adjust as needed
                          child: pw.Text(
                            'Status',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                              color: PdfColors.grey700,
                            ),
                          ),
                        ),
                        pw.SizedBox(
                          width: 140,
                        ), // spacing between label and chip
                        buildStatusChip(getStatusText(transaction.status)),
                      ],
                    ),

                    pw.SizedBox(height: 12),
                    buildPdfRow(
                      'Post Refrence ID',
                      getStatusText(transaction.referenceId),
                    ),
                    pw.SizedBox(height: 12),
                    buildPdfRow(
                      'Uploaded By',
                      getStatusText(transaction.uploadedBy),
                    ),
                    pw.SizedBox(height: 12),
                    buildPdfRow(
                      'Date & Time',
                      '${transaction.dateTime.day} ${monthName(transaction.dateTime.month)} ${transaction.dateTime.year}, ${formatTime(transaction.dateTime)}',
                    ),

                    pw.SizedBox(height: 12),
                  ],
                ),
              ),

              pw.Spacer(),

              // Footer
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.only(top: 20),
                decoration: const pw.BoxDecoration(
                  border: pw.Border(
                    top: pw.BorderSide(color: PdfColors.grey300, width: 1),
                  ),
                ),
                child: pw.Text(
                  '*This is a system-generated document.*',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey600,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  // TODO: Move this to a shared utility or enum handler
  String getStatusText(dynamic status) {
    return status.toString().split('.').last;
  }

  pw.Widget buildPdfRow(String label, String value) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Text(
            label,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 12,
              color: PdfColors.grey700,
            ),
          ),
        ),
        pw.Expanded(
          flex: 3,
          child: pw.Text(
            value,
            style: const pw.TextStyle(fontSize: 12, color: PdfColors.black),
          ),
        ),
      ],
    );
  }

  String formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = monthName(dateTime.month);
    final year = dateTime.year;
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$day $month $year, $hour:$minute $period';
  }

  // Maps status to color (similar to your Flutter StatusChip)
  PdfColor getStatusBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return PdfColors.lightGreen;
      case 'failed':
        return PdfColors.red100;
      case 'pending':
        return PdfColors.amber100;
      case 'ongoing':
      default:
        return PdfColors.green100;
    }
  }

  PdfColor getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return PdfColors.green900;
      case 'failed':
        return PdfColors.red900;
      case 'pending':
        return PdfColors.orange900;
      case 'ongoing':
      default:
        return PdfColors.green800;
    }
  }

  pw.Widget buildStatusChip(String status) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: pw.BoxDecoration(
        color: getStatusBackgroundColor(status),
        borderRadius: pw.BorderRadius.circular(20),
      ),
      child: pw.Text(
        status,
        style: pw.TextStyle(
          color: getStatusTextColor(status),
          fontWeight: pw.FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
