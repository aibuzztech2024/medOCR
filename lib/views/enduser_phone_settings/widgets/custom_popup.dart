import 'package:avatar/views/enduser_phone_settings/constants/settings_constants.dart';
import 'package:flutter/material.dart';

// Data model for sections
class DialogSection {
  final String title;
  final String content;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;

  const DialogSection({
    required this.title,
    required this.content,
    this.backgroundColor,
    this.titleStyle,
    this.contentStyle,
  });
}

class ReusablePopupDialog extends StatelessWidget {
  final String title;
  final Widget? content;
  final List<DialogSection>? sections;
  final VoidCallback? onClose;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Color? sectionBackgroundColor;
  final double? sectionSpacing;

  const ReusablePopupDialog({
    Key? key,
    required this.title,
    this.content,
    this.sections,
    this.onClose,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.sectionBackgroundColor,
    this.sectionSpacing,
  }) : assert(
         content != null || sections != null,
         'Either content or sections must be provided',
       ),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.9,
        height: height,
        constraints: BoxConstraints(
          maxWidth: 600,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with title and close button
            Container(
              padding: padding ?? const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (onClose != null) {
                        onClose!();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content area
            Flexible(
              child: Container(
                width: double.infinity,
                padding: padding ?? const EdgeInsets.all(20),
                child: content ?? _buildSectionsContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build sections content
  Widget _buildSectionsContent() {
    if (sections == null || sections!.isEmpty) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            sections!.asMap().entries.map((entry) {
              final index = entry.key;
              final section = entry.value;

              return Column(
                children: [
                  _buildSection(section),
                  if (index < sections!.length - 1)
                    SizedBox(height: sectionSpacing ?? 20),
                ],
              );
            }).toList(),
      ),
    );
  }

  // Build individual section
  Widget _buildSection(DialogSection section) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SettingsConstants.secondaryGreen,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style:
                section.titleStyle ??
                const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            section.content,
            style:
                section.contentStyle ??
                const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }

  // Static method to show the dialog
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    Widget? content,
    List<DialogSection>? sections,
    VoidCallback? onClose,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    Color? sectionBackgroundColor,
    double? sectionSpacing,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return ReusablePopupDialog(
          title: title,
          content: content,
          sections: sections,
          onClose: onClose,
          width: width,
          height: height,
          padding: padding,
          borderRadius: borderRadius,
          sectionBackgroundColor: sectionBackgroundColor,
          sectionSpacing: sectionSpacing,
        );
      },
    );
  }
}
