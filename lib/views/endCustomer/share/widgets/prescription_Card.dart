import 'package:flutter/material.dart';

import '../../../../models/endCustomer/share/prescription_Modal.dart';

class PrescriptionCard extends StatelessWidget {
  final PrescriptionDetail detail;
  final VoidCallback? onEdit;
  final VoidCallback? onAddAnother;

  const PrescriptionCard({Key? key, required this.detail, this.onEdit, this.onAddAnother}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    final theme = Theme.of(c);
    final grey = theme.colorScheme.onSurface.withOpacity(0.6);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 6, 6, 6),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(onTap: onEdit, child: Icon(Icons.edit_outlined, size: 24, color: Colors.orange)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              spacing: 12,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconTextRow(icon: Icons.person_outline_rounded, text: detail.patientName),
                    IconTextRow(icon: Icons.apps_outage_outlined, text: "${detail.age} Yrs"),
                    IconTextRow(icon: Icons.monitor_weight_outlined, text: "${detail.weight} Kg"),
                  ],
                ),

                const Divider(height: 1, thickness: 1),

                // Medicine & Diagnosis columns
                IntrinsicHeight(
                  child: Row(
                    children: [
                      // Medicine column
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Icon(Icons.local_pharmacy, size: 20, color: grey),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${detail.medicineName} ${detail.dosage}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                                  Text('${detail.frequency}. ${detail.method}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Icon(Icons.healing, size: 20, color: grey),
                            const SizedBox(width: 6),
                            Expanded(child: Text(detail.diagnosis, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1, thickness: 1),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {},
              child: Text('+ Add Another Prescription', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class IconTextRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;
  final double? iconSize;

  const IconTextRow({Key? key, required this.icon, required this.text, this.iconColor, this.iconSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Icon(icon, color: iconColor ?? Colors.black, size: iconSize ?? 20),
        const SizedBox(width: 4),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: screenWidth * 0.24),

          child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        ),
      ],
    );
  }
}
