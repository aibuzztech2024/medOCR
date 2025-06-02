// transaction_screen.dart
import 'package:avatar/viewModels/points/controller/transaction_controller.dart';
import 'package:avatar/views/points/widget/pdf_download_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:flutter/services.dart';

import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/views/points/widget/statuschip.dart';
import 'package:avatar/views/points/widget/transaction_row.dart';
import 'package:avatar/views/points/widget/transactionalimagecard_widget.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({super.key});

  final TransactionController controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Transaction Details'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          PdfDownloadButton(
            onGeneratePdf: _generatePdf,
            fileName: 'transaction_details.pdf',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          final transaction = controller.transaction.value;

          if (transaction == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TransactionImageCard(
                  istransaction: true,
                  imagePath: transaction.imagePath,
                ),
                const SizedBox(height: 16),
                TransactionRow(
                  label: 'Status',
                  value: StatusChip(status: transaction.status),
                ),
                TransactionRow(
                  label: 'File Type',
                  value: Text(transaction.fileType),
                ),
                TransactionRow(
                  label: 'Reward Points',
                  value: Text(transaction.rewardPoints.toString()),
                ),
                TransactionRow(
                  label: 'Date & Time',
                  value: Text(
                    '${transaction.dateTime.day} ${_monthName(transaction.dateTime.month)} ${transaction.dateTime.year}, '
                    '${_formatTime(transaction.dateTime)}',
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // TODO: Move this to a utility class for reusability
  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return months[month - 1];
  }

  // TODO: Consider using intl package for better date/time formatting
  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  // TODO: Add error handling for image loading failures
  // TODO: Add support for different image formats
  // TODO: Consider caching loaded images for better performance
  Future<pw.Document> _generatePdf() async {
    final transaction = controller.transaction.value;
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
          final ByteData imageData = await rootBundle.load(transaction.imagePath);
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
      print('Error loading transaction image: $e');
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
                    child: pw.Image(
                      transactionImage,
                      fit: pw.BoxFit.cover,
                    ),
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
                    _buildPdfRow('Status', _getStatusText(transaction.status)),
                    pw.SizedBox(height: 12),
                    _buildPdfRow('File Type', transaction.fileType),
                    pw.SizedBox(height: 12),
                    _buildPdfRow('Reward Points', transaction.rewardPoints.toString()),
                    pw.SizedBox(height: 12),
                    _buildPdfRow(
                      'Date & Time',
                      '${transaction.dateTime.day} ${_monthName(transaction.dateTime.month)} ${transaction.dateTime.year}, ${_formatTime(transaction.dateTime)}',
                    ),
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
                  'Generated on ${DateTime.now().day} ${_monthName(DateTime.now().month)} ${DateTime.now().year}',
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
  String _getStatusText(dynamic status) {
    // Handle different status types (enum, string, etc.)
    return status.toString().split('.').last; // For enum values
  }

  pw.Widget _buildPdfRow(String label, String value) {
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
            style: const pw.TextStyle(
              fontSize: 12,
              color: PdfColors.black,
            ),
          ),
        ),
      ],
    );
  }
}

