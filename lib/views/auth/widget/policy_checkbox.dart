import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/core/widgets/width_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PolicyCheckbox extends StatelessWidget {
  final Function(RxBool?) onChange;
  final String? message;
  const PolicyCheckbox({super.key, required this.onChange, this.message});

  @override
  Widget build(BuildContext context) {
    var isAccepted = false.obs;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1.3,
          child: SizedBox.fromSize(
            size: Size(24, 24),
            child: Obx(() {
              return Checkbox(
                side: BorderSide(color: context.theme.primaryColor, width: 1.5),
                visualDensity: VisualDensity.compact,
                value: isAccepted.value,
                onChanged: (_) {
                  isAccepted.toggle(); // Toggles acceptance
                  onChange(isAccepted); // Call the provided function
                },
              );
            }),
          ),
        ),
        WidthBox(8),
        // Terms text
        AppText.caption(
          message ??
              'I agree to the Terms of Service, Privacy Policy & Disclaimer',
          fontSize: 11,
          color: context.theme.primaryColor,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
