
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating; // e.g. 4.3
  final int starCount;
  final double size;
  final Color filledColor;
  final Color unfilledColor;

  const StarRating({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.size = 24,
    this.filledColor = Colors.amber,
    this.unfilledColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        final starFill = (rating - index).clamp(0.0, 1.0);
        return Stack(
          children: [
            Icon(Icons.star, color: unfilledColor, size: size),
            ClipRect(clipper: _StarClipper(starFill), child: Icon(Icons.star, color: filledColor, size: size)),
          ],
        );
      }),
    );
  }
}

class _StarClipper extends CustomClipper<Rect> {
  final double fillPercent; // 0.0 to 1.0

  _StarClipper(this.fillPercent);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * fillPercent, size.height);
  }

  @override
  bool shouldReclip(_StarClipper oldClipper) {
    return oldClipper.fillPercent != fillPercent;
  }
}

