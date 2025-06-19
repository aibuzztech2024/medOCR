import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OtherOptionsComponent extends StatelessWidget {
  final String title;
  final List<OptionItem> options;

  const OtherOptionsComponent({
    Key? key,
    this.title = 'Other Options',
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),

          // Options List
          ...options
              .map((option) => Column(children: [_buildOptionItem(option)]))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildOptionItem(OptionItem option) {
    return GestureDetector(
      onTap: option.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            // Icon container with border (40x40)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: Center(
                child: SvgPicture.asset(
                  option.iconAsset,
                  width: 24, // Slightly smaller icon to match design
                  height: 24,
                  colorFilter:
                      option.iconColor != null
                          ? ColorFilter.mode(option.iconColor!, BlendMode.srcIn)
                          : null,
                ),
              ),
            ),
            SizedBox(width: 12),

            // Title
            Expanded(
              child: Text(
                option.title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),

            // Arrow icon
            Icon(Icons.chevron_right, size: 20, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }
}

class OptionItem {
  final String iconAsset;
  final String title;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;

  const OptionItem({
    required this.iconAsset,
    required this.title,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
  });
}
