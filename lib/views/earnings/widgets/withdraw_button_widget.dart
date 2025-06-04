import 'package:flutter/material.dart';

class WithdrawButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const WithdrawButtonWidget({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFF8C00), width: 2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.access_time,
              color: const Color(0xFFFF8C00),
              size: 20,
            ),
            const SizedBox(width: 8),
            isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF8C00)),
                    ),
                  )
                : const Text(
                    'Withdraw',
                    style: TextStyle(
                      color: Color(0xFFFF8C00),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}