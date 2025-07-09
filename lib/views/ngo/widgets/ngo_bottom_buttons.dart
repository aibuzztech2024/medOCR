import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NgoBottomWidget extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onContinue;

  const NgoBottomWidget({
    Key? key,
    required this.onCancel,
    required this.onContinue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = Get.width;

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: OutlinedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF484848)),
                foregroundColor: const Color(0xFF484848),
                textStyle: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 1.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),  // same radius as ElevatedButton default
                ),
              ),
              child: const Text("Cancel"),
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B79F5),
                textStyle: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 1.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text("Continue"),
            ),
          ),
        ),
      ],
    );
  }
}
