import 'package:flutter/material.dart';

class RegistrationAndTaxDetailsSection extends StatefulWidget {
  const RegistrationAndTaxDetailsSection({super.key});

  @override
  State<RegistrationAndTaxDetailsSection> createState() =>
      _RegistrationAndTaxDetailsSectionState();
}

class _RegistrationAndTaxDetailsSectionState
    extends State<RegistrationAndTaxDetailsSection> {
  List<bool> isExpandedList = List.generate(5, (_) => false);

  final List<Map<String, String>> tileData = [
    {
      'title': 'PAN Card',
      'subtitle': 'Personal PAN linked to your account',
      'number': 'GST Number: 29ABCDE1234F2Z5',
      'image': 'assets/images/settings/doc.png',
    },
    {
      'title': 'Aadhaar Card',
      'subtitle': 'Government issued identity document',
      'number': 'GST Number: 29ABCDE1234F2Z5',
      'image': 'assets/images/settings/doc.png',
    },
    {
      'title': 'Tax Certificate',
      'subtitle': 'Your latest tax document',
      'number': 'GST Number: 29ABCDE1234F2Z5',
      'image': 'assets/images/settings/doc.png',
    },
    {
      'title': 'Shop License',
      'subtitle': 'Local body license for retail',
      'number': 'GST Number: 29ABCDE1234F2Z5',
      'image': 'assets/images/settings/doc.png',
    },
    {
      'title': 'Business Proof',
      'subtitle': 'Proof of business existence',
      'number': 'GST Number: 29ABCDE1234F2Z5',
      'image': 'assets/images/settings/doc.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Registration & Taxes Details',
            style: TextStyle(
              color: Color(0xFF1F1F1F),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Add your Personal Details',
            style: TextStyle(
              color: Color(0xFF484848),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),

          // Expandable tiles
          ...List.generate(tileData.length, (index) {
            final item = tileData[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  onExpansionChanged: (expanded) {
                    setState(() => isExpandedList[index] = expanded);
                  },
                  tilePadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF484848),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        item['number']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F1F1F),
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    isExpandedList[index]
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: const Color(0xFF484848),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item['image']!,
                              fit: BoxFit.contain,
                              width: double.infinity,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
