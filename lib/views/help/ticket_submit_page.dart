import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TicketSubmittedView extends StatelessWidget {
  const TicketSubmittedView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView( // Prevent overflow on small screens
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08), // Responsive padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ticket Title
                Text(
                  'Ticket Submitted!',
                  style: TextStyle(
                    fontSize: width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: height * 0.03),

                // Ticket Icon SVG
                SizedBox(
                  width: width * 0.18,
                  height: width * 0.18,
                  child: SvgPicture.asset(
                    'assets/icons/ticket1.svg',
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: height * 0.03),

                // Description Message
                Text(
                  'Please wait a minute, our awesome helper\nwill be with you shortly :)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 0.040,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: height * 0.05),

                // Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Know More Button
                    GestureDetector(
                      onTap: () {
                        // TODO: Implement Know More action
                      },
                      child: Container(
                        width: width * 0.35,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEDED),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Know More >>',
                            style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Go to Home Button
                    GestureDetector(
                      onTap: () {
                        // TODO: Implement Go to Home action
                      },
                      child: Container(
                        width: width * 0.35,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6F61),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Go to Home',
                            style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
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
    );
  }
}
