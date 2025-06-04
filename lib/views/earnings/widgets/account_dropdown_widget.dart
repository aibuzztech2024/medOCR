import 'package:flutter/material.dart';

class AccountDropdownWidget extends StatelessWidget {
  final String selectedAccount;
  final Function(String) onAccountSelected;
  final VoidCallback onAddAccount;
  final List<String> accounts;

  const AccountDropdownWidget({
    super.key,
    required this.selectedAccount,
    required this.onAccountSelected,
    required this.onAddAccount,
    required this.accounts,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFFF8C00), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedAccount,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFFFF8C00),
                ),
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onAccountSelected(newValue);
                  }
                },
                items: accounts.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: onAddAccount,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFF8C00),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
