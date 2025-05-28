// =============================================================================
// DONATION DETAIL PAGE - View Implementation
// =============================================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar/views/advertiser/donate/donation_model.dart';

class DonationDetailView extends StatelessWidget {
  final DonationModel donation;

  const DonationDetailView({Key? key, required this.donation})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text(
        donation.title,
        style: TextStyle(
          color: Colors.black,
          fontSize: Get.textScaleFactor * 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(Get.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(),
          SizedBox(height: Get.height * 0.03),
          _buildDetailsSection(),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      width: double.infinity,
      height: Get.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child:
            donation.imageUrl != null
                ? Image.network(
                  donation.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => _buildImagePlaceholder(),
                )
                : _buildImagePlaceholder(),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Icon(Icons.image, size: 64, color: Colors.grey[400]),
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      children: [
        _buildDetailRow('Post Name:', donation.title),
        SizedBox(height: Get.height * 0.025),
        _buildDetailRow('Date & Time:', _formatDateTime(donation.dateTime)),
        SizedBox(height: Get.height * 0.025),
        _buildDetailRow('Paid Donation:', donation.amount),
        SizedBox(height: Get.height * 0.025),
        _buildDetailRow('Status:', donation.status, isStatus: true),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isStatus = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Get.textScaleFactor * 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        isStatus ? _buildStatusChip(value) : _buildValueText(value),
      ],
    );
  }

  Widget _buildValueText(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: Get.textScaleFactor * 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey.shade400,
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'completed':
      case 'successful':
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[700]!;
        break;
      case 'pending':
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[700]!;
        break;
      default:
        backgroundColor = Colors.grey[100]!;
        textColor = Colors.grey[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: Get.textScaleFactor * 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  String _formatDateTime(String dateTime) {
    try {
      // If the dateTime is already in the desired format, return as is
      if (dateTime.contains('AM') || dateTime.contains('PM')) {
        return dateTime;
      }

      // Otherwise, try to parse and format
      final DateTime parsed = DateTime.parse(dateTime);
      final String formattedDate =
          '${parsed.day} ${_getMonthName(parsed.month)} ${parsed.year}';
      final String formattedTime =
          '${parsed.hour > 12 ? parsed.hour - 12 : parsed.hour}:${parsed.minute.toString().padLeft(2, '0')} ${parsed.hour >= 12 ? 'PM' : 'AM'}';
      return '$formattedDate $formattedTime';
    } catch (e) {
      // If parsing fails, return the original string
      return dateTime;
    }
  }

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
