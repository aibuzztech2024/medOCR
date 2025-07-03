import 'dart:developer';

import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AccountDropdownWidget extends StatefulWidget {
  final String selectedAccount;
  final Function(String) onAccountSelected;

  const AccountDropdownWidget({
    super.key,
    required this.selectedAccount,
    required this.onAccountSelected,
  });

  @override
  State<AccountDropdownWidget> createState() => _AccountDropdownWidgetState();
}

class _AccountDropdownWidgetState extends State<AccountDropdownWidget>
    with SingleTickerProviderStateMixin {
  static const _borderColor = LightThemeColors.pharmacyColor;
  static const _upiColor = LightThemeColors.pharmacyColor;
  static const _arrowSize = 24.0;

  bool _isExpanded = false;
  late final AnimationController _animationController;
  late final Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    setState(() => _isExpanded = !_isExpanded);
    _isExpanded
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor, width: 1),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDropdownHeader(),
          SizeTransition(
            sizeFactor: _expandAnimation,
            axisAlignment: -1,
            child: _buildExpandedContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownHeader() {
    return InkWell(
      onTap: _toggleDropdown,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.selectedAccount,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            AnimatedRotation(
              turns: _isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 300),
              child: const Icon(
                Icons.keyboard_arrow_down,
                size: _arrowSize,
                color: _borderColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildUpiLogo(),
          AppText.body('Active', fontWeight: FontWeight.w600),
          _buildIconButton(Icons.edit, Colors.black, 'Edit', () {
            // TODO: Implement edit functionality
            log('Edit ${widget.selectedAccount}');
          }),
          _buildIconButton(Icons.delete_outline, Colors.red, 'Delete', () {
            // TODO: Implement delete functionality
            log('Delete ${widget.selectedAccount}');
          }),
        ],
      ),
    );
  }

  Widget _buildUpiLogo() {
    return Container(
      width: 40,
      height: 24,
      decoration: BoxDecoration(
        color: _upiColor,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: const Text(
        'UPI',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildIconButton(
    IconData icon,
    Color color,
    String semanticLabel,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Icon(icon, size: 24, color: color, semanticLabel: semanticLabel),
    );
  }
}
