import 'package:flutter/material.dart';

/// Custom radio button widget for payment selection
class CustomRadioButton extends StatelessWidget {
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final double size;

  const CustomRadioButton({
    Key? key,
    required this.isSelected,
    this.selectedColor = const Color(0xFF4299E1),
    this.unselectedColor = const Color(0xFFD1D5DB),
    this.size = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? selectedColor : unselectedColor,
          width: 2,
        ),
      ),
      child:
          isSelected
              ? Center(
                child: Container(
                  width: size * 0.5,
                  height: size * 0.5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedColor,
                  ),
                ),
              )
              : null,
    );
  }
}
