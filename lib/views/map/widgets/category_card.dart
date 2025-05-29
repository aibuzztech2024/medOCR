import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/core/widgets/width_box.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String name, rating, reviewCount, address, phone;
  // To hide divider for last child
  final bool showDivider;
  const CategoryCard({
    super.key,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.address,
    required this.phone,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        AppText.heading(name),
        Row(
          spacing: 2,
          children: [
            AppText.body(rating.split(' ')[0]),
            WidthBox(5),
            ...List.generate(
              double.parse(rating.split(' ')[0]).round(),
              (index) => Icon(Icons.star, color: Colors.amber),
            ),
            WidthBox(2),
            AppText.body('($reviewCount)'),
          ],
        ),
        AppText.body(address),
        AppText.body(phone),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              //TODO: handle On click of direction
              onPressed: () {},
              icon: Icon(Icons.directions, size: 30),
            ),
            IconButton(
              //TODO: handle On click of direction
              onPressed: () {},
              icon: Icon(Icons.call, size: 30),
            ),
            IconButton(
              //TODO: handle On click of direction
              onPressed: () {},
              icon: Icon(Icons.share, size: 30),
            ),
          ],
        ),
        if (showDivider) Divider(color: Colors.blue, thickness: 0.5),
      ],
    );
  }
}
