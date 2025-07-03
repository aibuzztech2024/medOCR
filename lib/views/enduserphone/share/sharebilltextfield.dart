import 'package:avatar/views/enduserphone/share/upload_file_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_button.dart';
import '../../../models/hospital/prescription_card_model.dart';

/// Model class holding invoice data fields
class InvoiceModel {
  String patientName;
  String doctorName;
  String invoiceNo;
  String totalBill;
  String billDate;
  String paymentMethod;
  String pharmacyName;
  String pharmacyGstNo;
  String medicineName;
  String batchNo;
  String expiryDate;
  String medicineType;
  String quantity;
  String unitPrice;
  String discount;
  String gst;
  String totalPrice;

  InvoiceModel({
    required this.patientName,
    required this.doctorName,
    required this.invoiceNo,
    required this.totalBill,
    required this.billDate,
    required this.paymentMethod,
    required this.pharmacyName,
    required this.pharmacyGstNo,
    required this.medicineName,
    required this.batchNo,
    required this.expiryDate,
    required this.medicineType,
    required this.quantity,
    required this.unitPrice,
    required this.discount,
    required this.gst,
    required this.totalPrice,
  });
}

/// ViewModel to hold data and text controllers for editing invoice fields
class InvoiceViewModel {
  late InvoiceModel invoice;

  // Map holding TextEditingControllers for each input field by label
  final Map<String, TextEditingController> controllers = {};

  InvoiceViewModel() {
    // Initialize invoice with sample data
    invoice = InvoiceModel(
      patientName: 'John Deo',
      doctorName: 'Dr. Monika',
      invoiceNo: '20250503-001',
      totalBill: '512',
      billDate: '21/04/25',
      paymentMethod: 'Credit Card',
      pharmacyName: 'Pharma Chemist',
      pharmacyGstNo: '001-20250503',
      medicineName: 'Crocin',
      batchNo: 'BXP1234',
      expiryDate: '21/04/25',
      medicineType: 'Tablet',
      quantity: '10 Tablet',
      unitPrice: '₹ 5.00',
      discount: '0%',
      gst: '12%',
      totalPrice: '₹ 56.00',
    );

    // Initialize controllers with invoice data
    controllers['Patient Name'] = TextEditingController(
      text: invoice.patientName,
    );
    controllers['Doctor Name'] = TextEditingController(
      text: invoice.doctorName,
    );
    controllers['Invoice No.'] = TextEditingController(text: invoice.invoiceNo);
    controllers['Total Bill'] = TextEditingController(text: invoice.totalBill);
    controllers['Bill Date'] = TextEditingController(text: invoice.billDate);
    controllers['Payment Method'] = TextEditingController(
      text: invoice.paymentMethod,
    );
    controllers['Pharmacy Name'] = TextEditingController(
      text: invoice.pharmacyName,
    );
    controllers['Pharmacy GST No.'] = TextEditingController(
      text: invoice.pharmacyGstNo,
    );
    controllers['Medicine Name'] = TextEditingController(
      text: invoice.medicineName,
    );
    controllers['Batch No.'] = TextEditingController(text: invoice.batchNo);
    controllers['Expiry Date'] = TextEditingController(
      text: invoice.expiryDate,
    );
    controllers['Medicine Type'] = TextEditingController(
      text: invoice.medicineType,
    );
    controllers['Quantity'] = TextEditingController(text: invoice.quantity);
    controllers['Unit Price'] = TextEditingController(text: invoice.unitPrice);

    // Discount controller with listener to ensure % always at the end
    controllers['Discount'] = TextEditingController(text: invoice.discount);
    controllers['Discount']!.addListener(() {
      final text = controllers['Discount']!.text;
      if (!text.endsWith('%')) {
        // Remove any existing %, then append %
        controllers['Discount']!.text = text.replaceAll('%', '') + '%';
        // Move cursor just before %
        controllers['Discount']!.selection = TextSelection.fromPosition(
          TextPosition(offset: controllers['Discount']!.text.length - 1),
        );
      }
    });

    // GST controller with listener to ensure % always at the end
    controllers['GST'] = TextEditingController(text: invoice.gst);
    controllers['GST']!.addListener(() {
      final text = controllers['GST']!.text;
      if (!text.endsWith('%')) {
        controllers['GST']!.text = text.replaceAll('%', '') + '%';
        controllers['GST']!.selection = TextSelection.fromPosition(
          TextPosition(offset: controllers['GST']!.text.length - 1),
        );
      }
    });

    controllers['Total Price'] = TextEditingController(
      text: invoice.totalPrice,
    );
  }
}

/// Main Widget showing invoice form with text fields
class ShareBillTextfield extends StatefulWidget {
  final PrescriptionCardModel? initialModel;
  const ShareBillTextfield({Key? key, this.initialModel}) : super(key: key);

  @override
  State<ShareBillTextfield> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<ShareBillTextfield> {
  late final InvoiceViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = InvoiceViewModel();
    // Prefill from initialModel if provided
    if (widget.initialModel != null) {
      final m = widget.initialModel!;
      viewModel.controllers['Patient Name']?.text = m.patientName;
      viewModel.controllers['Doctor Name']?.text = m.doctorName;
      viewModel.controllers['Medicine Name']?.text = m.medicineName;
      viewModel.controllers['Quantity']?.text = m.frequency;
      viewModel.controllers['Unit Price']?.text = m.dosage;
      // Add more mappings as needed
    }
  }

  void _onSave() {
    final updatedModel = PrescriptionCardModel(
      patientName: viewModel.controllers['Patient Name']?.text ?? '',
      gender: widget.initialModel?.gender ?? '',
      age: widget.initialModel?.age ?? 0,
      weight: widget.initialModel?.weight ?? 0,
      prescriptionDate: widget.initialModel?.prescriptionDate ?? DateTime.now(),
      diagnosis: widget.initialModel?.diagnosis ?? '',
      doctorName: viewModel.controllers['Doctor Name']?.text ?? '',
      speciality: widget.initialModel?.speciality ?? '',
      regNo: widget.initialModel?.regNo ?? '',
      contact: widget.initialModel?.contact ?? '',
      medicineName: viewModel.controllers['Medicine Name']?.text ?? '',
      frequency: viewModel.controllers['Quantity']?.text ?? '',
      duration: widget.initialModel?.duration ?? '',
      method: widget.initialModel?.method ?? '',
      dosage: viewModel.controllers['Unit Price']?.text ?? '',
      instructions: widget.initialModel?.instructions ?? '',
    );
    Get.back(result: updatedModel);
  }

  /// Widget for section titles with spacing
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  /// Widget to create a single input field with optional suffixText (like '%')
  Widget field(String label, {String? suffixText}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label.isNotEmpty)
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            const SizedBox(height: 4),
            TextField(
              controller: viewModel.controllers[label],
              style: const TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                suffixText: suffixText,
                suffixStyle: const TextStyle(color: Colors.grey),
              ),
              keyboardType:
                  (label == 'Discount' || label == 'GST')
                      ? TextInputType.number
                      : TextInputType.text,
            ),
            if (label.isNotEmpty) const Divider(height: 12),
          ],
        ),
      ),
    );
  }

  /// Widget to create a row with two input fields side by side,
  /// optionally with suffixText for each field
  Widget rowFields(
    String label1,
    String label2, {
    String? suffix1,
    String? suffix2,
  }) {
    return Row(
      children: [
        field(label1, suffixText: suffix1),
        field(label2, suffixText: suffix2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Patient & Doctor Info"),
            rowFields("Patient Name", "Doctor Name"),

            sectionTitle("Invoice & Bill Info"),
            rowFields("Invoice No.", "Total Bill"),
            rowFields("Bill Date", "Payment Method"),

            sectionTitle("Pharmacy Info"),
            rowFields("Pharmacy Name", "Pharmacy GST No."),

            sectionTitle("Medicine Info"),
            rowFields("Medicine Name", "Batch No."),
            rowFields("Expiry Date", "Medicine Type"),
            rowFields("Quantity", "Unit Price"),

            Row(children: [field("Discount"), field("GST")]),

            rowFields("Total Price", ""),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: AppButton(
                    type: ButtonType.outlined,
                    text: 'Cancel',
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: AppButton(
                    type: ButtonType.filled,
                    text: 'Save',
                    onPressed: _onSave,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
