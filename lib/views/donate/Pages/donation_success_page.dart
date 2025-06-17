import 'package:flutter/material.dart';

class DonationSuccessPage extends StatelessWidget {
  final double amount;
  final int childrenFed;
  final double pointsEarned;

  const DonationSuccessPage({
    super.key,
    this.amount = 500,         // Default donation amount
    this.childrenFed = 10,     // Default children fed
    this.pointsEarned = 2.8,   // Default reward points
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: width > 400 ? 389 : width * 0.9,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: const Border(
                top: BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Success Image
                  Image.asset(
                    'assets/images/done.png',
                    width: 95,
                    height: 120,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 8),

                  // Amount and Children Fed
                  Text(
                    'Your ₹${amount.toStringAsFixed(0)} will feed $childrenFed children today',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Points Earned
                  Text.rich(
                    TextSpan(
                      text: 'Congratulations! You have earned ',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                      children: [
                        TextSpan(
                          text: '${pointsEarned.toStringAsFixed(1)}',
                          style: const TextStyle(
                            color: Color(0xFFFF9900),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(
                          text: ' Points on the Platform Usage',
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  // Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Donate More Button
                      OutlinedButton(
                        onPressed: () {
                          // TODO: Add action
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFFDF4DC),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: const BorderSide(color: Color(0xFFFDF4DC)),
                        ),
                        child: const Text(
                          'Donate More',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      // Go to Home Button
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate home
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF9900),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Go to Home',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
