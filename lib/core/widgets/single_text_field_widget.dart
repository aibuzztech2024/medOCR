import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/core/widgets/height_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleTextFieldWidget extends StatelessWidget {
  final String label;
  final RxString value;
  final bool showDropdown;
  final VoidCallback? onTap;
  final bool isEditable;
  final TextInputType? keyboardType;
  final TextEditingController? textController;

  const SingleTextFieldWidget({
    super.key,
    required this.label,
    required this.value,
    this.showDropdown = false,
    this.onTap,
    this.isEditable = true,
    this.keyboardType,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final labelFontSize = width * 0.045; // Responsive font size for label
    final valueFontSize = width * 0.043; // Responsive font size for value
    final dividerThickness = width * 0.003; // Responsive divider thickness
    final verticalSpacing = height * 0.0001;
    final iconSize = width * 0.055;

    return GestureDetector(
      onTap: showDropdown ? onTap : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.body(
            label,
            fontSize: labelFontSize,
            fontWeight: FontWeight.w500,
            color: LightThemeColors.hintText, // Darker label color
          ),
          HeightBox(verticalSpacing),
          Row(
            children: [
              Expanded(
                child:
                    showDropdown || !isEditable
                        ? Obx(
                          () => AppText.body(
                            value.value,
                            fontSize: valueFontSize,
                            color:
                                value.value.isNotEmpty
                                    ? const Color(0xFF222222)
                                    : Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                        : TextField(
                          controller: textController,
                          onChanged: (val) => value.value = val,
                          style: TextStyle(
                            fontSize: valueFontSize,
                            color: const Color(0xFF222222),
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          keyboardType: keyboardType,
                        ),
              ),
              if (showDropdown)
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.grey[800],
                  size: iconSize,
                ),
            ],
          ),
          Divider(thickness: dividerThickness, color: Colors.grey[400]),
          HeightBox(verticalSpacing * 1.3),
        ],
      ),
    );
  }
}
