import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar/views/advertiser/donate/donation_model.dart';
import 'donation_detail_controller.dart';

class DonationDetailView extends StatelessWidget {
  final DonationModel donation;

  const DonationDetailView({Key? key, required this.donation})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DonationDetailController(donation: donation));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(controller),
      body: _buildBody(controller),
    );
  }

  AppBar _buildAppBar(DonationDetailController controller) {
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
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined, color: Colors.black),
          onPressed: controller.handlePdfShare,
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.download, color: Colors.black),
          onPressed: controller.handlePdfDownload,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildBody(DonationDetailController controller) {
    return Padding(
      padding: EdgeInsets.all(Get.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(),
          SizedBox(height: Get.height * 0.03),
          _buildDetailsSection(controller),
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
            color: Colors.black.withValues(alpha: 0.1),
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

  Widget _buildDetailsSection(DonationDetailController controller) {
    return Column(
      children: [
        _buildDetailRow('Post Name:', donation.title),
        SizedBox(height: Get.height * 0.025),
        _buildDetailRow(
          'Date & Time:',
          controller.formatDateTime(donation.dateTime),
        ),
        SizedBox(height: Get.height * 0.025),
        _buildDetailRow('Paid Donation:', donation.amount),
        SizedBox(height: Get.height * 0.025),
        _buildDetailRow(
          'Status:',
          donation.status,
          controller: controller,
          isStatus: true,
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    DonationDetailController? controller,
    bool isStatus = false,
  }) {
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
        isStatus && controller != null
            ? _buildStatusChip(value, controller)
            : _buildValueText(value),
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

  Widget _buildStatusChip(String status, DonationDetailController controller) {
    final statusProps = controller.getStatusProperties(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusProps['backgroundColor'],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusProps['displayStatus'],
        style: TextStyle(
          fontSize: Get.textScaleFactor * 12,
          fontWeight: FontWeight.w600,
          color: statusProps['textColor'],
        ),
      ),
    );
  }
}
