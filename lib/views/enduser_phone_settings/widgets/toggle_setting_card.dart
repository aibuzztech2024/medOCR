import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ToggleSettingCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;

  const ToggleSettingCard({
    Key? key,
    required this.icon,
    required this.title,
    this.initialValue = false,
    this.onChanged,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  State<ToggleSettingCard> createState() => _ToggleSettingCardState();
}

class _ToggleSettingCardState extends State<ToggleSettingCard> {
  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _isEnabled = widget.initialValue;
  }

  void _handleToggle(bool value) {
    setState(() {
      _isEnabled = value;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(widget.icon, size: 20, color: Colors.grey.shade600),

          const SizedBox(width: 16),
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
          ),
          FlutterSwitch(
            width: 50.0,
            height: 30.0,
            valueFontSize: 12.0,
            toggleSize: 24.0,
            value: _isEnabled,
            borderRadius: 30.0,
            padding: 3.0,
            showOnOff: false,
            onToggle: _handleToggle,
            activeColor: widget.activeColor ?? const Color(0xFFFF8C00),
            inactiveColor: widget.inactiveColor ?? Colors.grey.shade300,
            toggleColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

// Example usage in a screen
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ToggleSettingCard(
            icon: Icons.notifications,
            title: 'In-App Notification',
            initialValue: true,
            onChanged: (value) {
              print('In-App Notification: $value');
            },
          ),
          ToggleSettingCard(
            icon: Icons.email_outlined,
            title: 'Email Notification',
            initialValue: false,
            onChanged: (value) {
              print('Email Notification: $value');
            },
          ),
          // Add more toggle cards as needed
        ],
      ),
    );
  }
}
