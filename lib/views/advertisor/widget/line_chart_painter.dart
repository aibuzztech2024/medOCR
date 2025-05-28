import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  final List<Offset>? customPoints;
  final Color? lineColor;
  final double? strokeWidth;

  LineChartPainter({
    this.customPoints,
    this.lineColor,
    this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor ?? Colors.red[400]!
      ..strokeWidth = strokeWidth ?? 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Use custom points or default sample data
    final points = customPoints ?? [
      Offset(0, size.height * 0.6),
      Offset(size.width * 0.15, size.height * 0.2),
      Offset(size.width * 0.3, size.height * 0.3),
      Offset(size.width * 0.45, size.height * 0.4),
      Offset(size.width * 0.6, size.height * 0.15),
      Offset(size.width * 0.75, size.height * 0.8),
      Offset(size.width * 0.9, size.height * 0.2),
      Offset(size.width, size.height * 0.9),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);

    // Draw dots at data points
    final dotPaint = Paint()
      ..color = lineColor ?? Colors.red[400]!
      ..style = PaintingStyle.fill;

    for (final point in points) {
      canvas.drawCircle(point, 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}