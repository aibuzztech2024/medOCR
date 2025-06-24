import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocationSelectionHeader extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onSwapPressed;
  final Function(String)? onStartLocationChanged;
  final Function(String)? onDestinationChanged;
  final TextEditingController? startLocationController;
  final TextEditingController? destinationController;
  final String? destinationHint;

  const LocationSelectionHeader({
    Key? key,
    this.onBackPressed,
    this.onSwapPressed,
    this.onStartLocationChanged,
    this.onDestinationChanged,
    this.startLocationController,
    this.destinationController,
    this.destinationHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              // Search inputs column with icons
              Expanded(
                child: Row(
                  children: [
                    // Icons and dashed line column
                    Column(
                      children: [
                        // Start location icon (circle)
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey[400]!,
                              width: 2,
                            ),
                          ),
                        ),
                        // Dashed line
                        Container(
                          width: 2,
                          height: 40,
                          child: CustomPaint(painter: DashedLinePainter()),
                        ),
                        // Destination icon (red pin)
                        SvgPicture.asset('assets/icons/maps/location_icon.svg'),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // Text fields column
                    Expanded(
                      child: Column(
                        children: [
                          // Start location input
                          TextField(
                            controller: startLocationController,
                            onChanged: (value) {
                              // Debug log
                              if (onStartLocationChanged != null) {
                                onStartLocationChanged!(value);
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Choose start location',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 11,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Destination input
                          TextField(
                            controller: destinationController,
                            onChanged: (value) {
                              print(
                                'Destination input changed: $value',
                              ); // Debug log
                              if (onDestinationChanged != null) {
                                onDestinationChanged!(value);
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Choose end location',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: onSwapPressed,
                child: SvgPicture.asset('assets/icons/maps/swap_icon.svg'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom painter for dashed line
class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.grey[400]!
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    const dashHeight = 3.0;
    const dashSpace = 2.0;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
