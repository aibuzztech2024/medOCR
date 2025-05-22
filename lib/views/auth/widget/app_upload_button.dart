import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUploadButton extends StatelessWidget {
  final VoidCallback onUpload;
  const AppUploadButton({super.key, required this.onUpload});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: DottedBorder(
        padding: EdgeInsets.all(2),
        strokeWidth: 1.5,
        dashPattern: [4, 2],
        radius: Radius.circular(10),
        borderType: BorderType.RRect,
        color: context.theme.primaryColor,
        borderPadding: EdgeInsets.all(0),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: onUpload,
              splashColor: context.theme.hintColor.withOpacity(.1),
              child: SizedBox(
                height: 50,
                width: double.maxFinite,
                child: Icon(Icons.upload, size: 30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
