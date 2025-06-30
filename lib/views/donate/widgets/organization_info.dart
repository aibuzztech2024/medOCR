import 'package:flutter/material.dart';

class OrganizationInfoRow extends StatelessWidget {
  final String logoUrl;
  final String organizationName;
  final String organizationWebsite;
  final VoidCallback? onVisitPressed;

  const OrganizationInfoRow({
    Key? key,
    required this.logoUrl,
    required this.organizationName,
    required this.organizationWebsite,
    this.onVisitPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            logoUrl,
            width: width * 0.12,
            height: width * 0.12,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: width * 0.04),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                organizationName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: width * 0.042,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: height * 0.005),
              Text(
                organizationWebsite,
                style: TextStyle(
                  fontSize: width * 0.035,
                  color: Colors.black54,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: onVisitPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            minimumSize: const Size(0, 0),
          ),
          child: const Text(
            "Visit",
            style: TextStyle(
              color: Colors.orange,
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }
}
