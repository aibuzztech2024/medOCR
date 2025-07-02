import 'dart:io';
import 'package:flutter/material.dart';

class UploadFilePreview extends StatelessWidget {
  final File file;
  final VoidCallback? onRemove; // Optional remove button

  const UploadFilePreview({
    super.key,
    required this.file,
    this.onRemove,
  });

  bool _isPdf(String path) {
    return path.toLowerCase().endsWith('.pdf');
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file.path.split('/').last;
    final isPdf = _isPdf(file.path);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // File thumbnail (image or PDF icon)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: isPdf
                ? Container(
              width: 48,
              height: 48,
              color: Colors.red.shade100,
              child: const Icon(Icons.picture_as_pdf, color: Colors.red),
            )
                : Image.file(
              file,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // File name and scan status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(Icons.check_box, size: 18, color: Colors.green),
                    SizedBox(width: 4),
                    Text(
                      "Virus scan",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Remove button (if provided)
          if (onRemove != null)
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.close, color: Colors.black54),
              splashRadius: 20,
            ),
        ],
      ),
    );
  }
}
