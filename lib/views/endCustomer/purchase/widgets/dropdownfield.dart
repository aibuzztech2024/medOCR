import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final String label;
  final List<String> items;
  final String value;
  final Function(String) onChanged;

  const DropdownField({super.key, required this.label, required this.items, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle()),

        DropdownButton<String>(
          padding: EdgeInsets.zero,
          isExpanded: true,
          isDense: true,
          alignment: Alignment.bottomCenter,
          // hint: Text(label),
          value: value.isEmpty ? null : value,
          onChanged: (val) {
            onChanged(val ?? ''); // optional: pass empty string when null is selected
          },
          items: [
            const DropdownMenuItem<String>(value: null, child: Text('None', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black))),
            ...items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black)))),
          ],
        ),
      ],
    );
  }
}
