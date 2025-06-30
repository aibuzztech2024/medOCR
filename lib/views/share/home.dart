import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/core/widgets/height_box.dart';
import 'package:avatar/core/widgets/width_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShareHome extends StatelessWidget {
  const ShareHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Placeholder(fallbackHeight: 150),
              HeightBox(16),

              // Tab Buttons
              Row(
                children: const [
                  _TabButton(
                    title: 'Home',
                    assetPath: 'assets/images/share/homeicon.svg',
                    isActive: true,
                  ),
                  WidthBox(8),
                  _TabButton(
                    title: 'History',
                    assetPath: 'assets/images/share/historyicon.svg',
                    isActive: false,
                  ),
                ],
              ),

              HeightBox(24),

              // Points Earned Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF6EC), // updated background color
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 4,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/share/trophy.svg',
                      height: 60,
                      width: 60,
                    ),

                    AppText.body(
                      'Share Points Earned',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    HeightBox(4),
                    AppText.body(
                      '400',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),

              HeightBox(32),
              AppText.heading('Upload Documents'),
              HeightBox(12),

              // Document List
              Column(
                children: const [
                  DocumentItem(
                    title: 'Prescription',
                    imagePath: 'assets/images/share/prescriptionicon.svg',
                    borderColor: Color(0xFF3586FC),
                    backgroundColor: Color(0xFFECF0F6),
                  ),
                  DocumentItem(
                    title: 'Bills',
                    imagePath: 'assets/images/share/billsicon.svg',
                    borderColor: Color(0xFFCD6200),
                    backgroundColor: Color(0xFFF4EFEA),
                  ),
                  DocumentItem(
                    title: 'Medicine',
                    imagePath: 'assets/images/share/medicineicon.svg',
                    borderColor: Color(0xFF3AAFA9),
                    backgroundColor: Color(0xFFEDF2F2),
                  ),
                ],
              ),
              HeightBox(24),
              AppText.heading('Recent Upload'),
            ],
          ),
        ),
      ),
    );
  }
}

// Tab Button Widget
class _TabButton extends StatelessWidget {
  final String title;
  final String assetPath;
  final bool isActive;

  const _TabButton({
    required this.title,
    required this.assetPath,
    required this.isActive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isActive ? const Color(0xFFFAF6EC) : Colors.grey.shade200;
    final borderColor = isActive ? const Color(0xFFF79E1B) : Colors.grey;
    final textColor = isActive ? const Color(0xFFF79E1B) : Colors.black54;
    final iconColor = textColor;

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(assetPath, height: 20, color: iconColor),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// Right Border ListTile
class DocumentItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color borderColor;
  final Color backgroundColor;

  const DocumentItem({
    required this.title,
    required this.imagePath,
    required this.borderColor,
    required this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        border: Border(
          left: BorderSide(color: borderColor, width: 4),
          right: BorderSide.none,
          top: BorderSide.none,
          bottom: BorderSide.none,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: borderColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SvgPicture.asset(
            imagePath,
            height: 24,
            width: 24,
            color: borderColor,
          ),
        ],
      ),
    );
  }
}
