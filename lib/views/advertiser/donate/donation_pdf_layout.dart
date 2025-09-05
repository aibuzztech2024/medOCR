import 'package:avatar/views/advertiser/donate/donation_pdf_generator_service.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:avatar/views/advertiser/donate/donation_model.dart';

class PdfLayoutBuilder {
  /// Build complete PDF document for donation
  static pw.Document buildDonationPdf(
    DonationModel donation,
    pw.ImageProvider? imageProvider,
  ) {
    final pdf = pw.Document();
    final downloadedOn = PdfGenerationService.formatDateTime(DateTime.now());

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              buildHeader(),
              pw.SizedBox(height: 30),
              buildImageSection(imageProvider),
              pw.SizedBox(height: 40),
              buildDetailsSection(donation, downloadedOn),
              pw.Spacer(),
              buildFooter(),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  /// Build PDF header
  static pw.Widget buildHeader() {
    return pw.Center(
      child: pw.Text(
        'Donation Details',
        style: pw.TextStyle(
          fontSize: 24,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.black,
        ),
      ),
    );
  }

  /// Build image section
  static pw.Widget buildImageSection(pw.ImageProvider? imageProvider) {
    if (imageProvider != null) {
      return pw.Center(
        child: pw.Container(
          width: 300,
          height: 200,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300),
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.ClipRRect(
            child: pw.Image(imageProvider, fit: pw.BoxFit.cover),
          ),
        ),
      );
    } else {
      return pw.Center(
        child: pw.Container(
          width: 300,
          height: 200,
          decoration: pw.BoxDecoration(
            color: PdfColors.grey100,
            border: pw.Border.all(color: PdfColors.grey300),
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Center(
            child: pw.Text(
              'No Image Available',
              style: pw.TextStyle(color: PdfColors.grey600, fontSize: 14),
            ),
          ),
        ),
      );
    }
  }

  /// Build details section
  static pw.Widget buildDetailsSection(
    DonationModel donation,
    String downloadedOn,
  ) {
    return pw.Column(
      children: [
        buildDetailRow('Post Name', donation.title),
        pw.SizedBox(height: 20),
        buildDetailRow('Date & Time', donation.dateTime),
        pw.SizedBox(height: 20),
        buildDetailRow('Paid Donation', donation.amount),
        pw.SizedBox(height: 20),
        buildStatusRow('Status', donation.status),
        pw.SizedBox(height: 30),
        buildDivider(),
        pw.SizedBox(height: 30),
        buildDetailRow(
          'Post Reference ID',
          donation.postReferenceId ??
              'AVTR${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
        ),
        pw.SizedBox(height: 20),
        buildDetailRow('Uploaded By', donation.uploadedBy ?? '@username123'),
        pw.SizedBox(height: 20),
        buildDetailRow('Downloaded On', downloadedOn),
      ],
    );
  }

  /// Build detail row
  static pw.Widget buildDetailRow(String label, String value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Text(
            '$label:',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.black,
            ),
          ),
        ),
        pw.Expanded(
          flex: 3,
          child: pw.Text(
            value,
            style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
            textAlign: pw.TextAlign.right,
          ),
        ),
      ],
    );
  }

  /// Build status row with colored background
  static pw.Widget buildStatusRow(String label, String status) {
    final statusProps = _getStatusProperties(status);

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Text(
            '$label:',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.black,
            ),
          ),
        ),
        pw.Expanded(
          flex: 3,
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: pw.BoxDecoration(
                color: statusProps['backgroundColor'],
                borderRadius: pw.BorderRadius.circular(10),
              ),
              child: pw.Text(
                statusProps['displayStatus'],
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                  color: statusProps['textColor'],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build divider
  static pw.Widget buildDivider() {
    return pw.Divider(color: PdfColors.grey300, thickness: 1);
  }

  /// Build PDF footer
  static pw.Widget buildFooter() {
    return pw.Center(
      child: pw.Text(
        'This is a system-generated document.',
        style: pw.TextStyle(
          fontSize: 10,
          color: PdfColors.grey600,
          fontStyle: pw.FontStyle.italic,
        ),
      ),
    );
  }

  /// Get status display properties
  static Map<String, dynamic> _getStatusProperties(String status) {
    PdfColor backgroundColor;
    PdfColor textColor;
    String displayStatus = status;

    if (status.toLowerCase() == 'completed') {
      displayStatus = 'Successful';
    }

    switch (status.toLowerCase()) {
      case 'completed':
      case 'successful':
        backgroundColor = PdfColor.fromHex('#E8F5E8');
        textColor = PdfColor.fromHex('#2E7D32');
        break;
      case 'pending':
        backgroundColor = PdfColor.fromHex('#FFF3E0');
        textColor = PdfColor.fromHex('#F57C00');
        break;
      default:
        backgroundColor = PdfColors.grey100;
        textColor = PdfColors.grey700;
    }

    return {
      'displayStatus': displayStatus,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
    };
  }
}
