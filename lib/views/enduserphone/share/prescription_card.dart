import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/models/hospital/prescription_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/icons_paths.dart';

/// TO-DO  change icons acc to figma designs
class PrescriptionCard extends StatelessWidget {
  final PrescriptionCardModel detail;
  final VoidCallback? onEdit;
  final VoidCallback? onAddAnother;

  const PrescriptionCard({
    Key? key,
    required this.detail,
    this.onEdit,
    this.onAddAnother,
  }) : super(key: key);

  @override
  Widget build(BuildContext c) {
    final theme = Theme.of(c);
    final grey = theme.colorScheme.onSurface.withOpacity(0.6);

    return Card(
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
              child: GestureDetector(
                onTap: onEdit,
                child: Icon(
                  Icons.edit_outlined,
                  size: 24,
                  color: LightThemeColors.pharmacyprimarycolor,
                ),
              ),
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
                    IconTextRow(
                      icon: IconsPaths.user_icon,
                      text: detail.patientName,
                      iconSize: 16,
                    ),
                    IconTextRow(
                      icon: IconsPaths.age_icon,
                      text: "${detail.age} Yrs",
                    ),
                    IconTextRow(
                      icon: IconsPaths.weight_icon,
                      text: "${detail.weight} Kg",
                    ),
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
                            SvgPicture.asset(
                              IconsPaths.medicine_icon,
                              height: 18,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${detail.medicineName} ${detail.dosage}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
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
                            SvgPicture.asset(
                              IconsPaths.stethoscope_icon,
                              height: 22,
                            ),

                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                detail.diagnosis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
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
              child: Text(
                '+ Add Another Prescription',
                style: TextStyle(
                  color: LightThemeColors.pharmacyprimarycolor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class IconTextRow extends StatelessWidget {
  final String icon;
  final String text;
  final Color? iconColor;
  final double? iconSize;

  const IconTextRow({
    Key? key,
    required this.icon,
    required this.text,
    this.iconColor,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          color: iconColor ?? null,
          height: iconSize ?? 20,
        ),
        const SizedBox(width: 6),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: screenWidth * 0.24),

          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
