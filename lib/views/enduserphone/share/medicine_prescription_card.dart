import 'package:flutter/material.dart';

import '../../../core/themes/light/light_theme_colors.dart';
import '../../../models/hospital/medicine_info_model.dart';

class MedicinePrescriptionCard extends StatelessWidget {
  final MedicineInfoModel model;
  final VoidCallback? onEdit;
  final VoidCallback? onAddAnother;

  const MedicinePrescriptionCard({
    Key? key,
    required this.model,
    this.onEdit,
    this.onAddAnother,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.medicineName,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Row(
                  children: [
                    Text(
                      '₹ ${model.productPrice}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onEdit,
                      child: Icon(
                        Icons.edit_outlined,
                        color: LightThemeColors.buttoncolors,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.confirmation_number_outlined,
                  size: 18,
                  color: Colors.grey[700],
                ),
                const SizedBox(width: 6),
                Text(model.batchNo, style: TextStyle(fontSize: 15)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.date_range, size: 18, color: Colors.grey[700]),
                const SizedBox(width: 6),
                Text(
                  '${model.manufacturingDate} - ${model.expiryDate}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.business, size: 18, color: Colors.grey[700]),
                const SizedBox(width: 6),
                Text(model.manufacture, style: TextStyle(fontSize: 15)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}