import 'package:avatar/views/enduser_phone_settings/constants/settings_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ToggleSettingCard extends StatefulWidget {
  // Icon to be displayed (IconData)
  final IconData? icon;

  // SVG asset path for the icon
  final String? svgAsset;

  final String title;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? iconColor;
  final double? iconSize;

  /// Constructor for ToggleSettingCard
  /// Either [icon] OR [svgAsset] must be provided, but not both
  const ToggleSettingCard({
    Key? key,
    this.icon,
    this.svgAsset,
    required this.title,
    this.initialValue = false,
    this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.iconColor,
    this.iconSize,
  }) : assert(
         (icon != null) ^ (svgAsset != null),
         'Either icon or svgAsset must be provided, but not both',
       ),
       super(key: key);

  /// Factory constructor for creating toggle card with IconData
  factory ToggleSettingCard.withIcon({
    required IconData icon,
    required String title,
    bool initialValue = false,
    ValueChanged<bool>? onChanged,
    Color? activeColor,
    Color? inactiveColor,
    Color? iconColor,
    double? iconSize,
  }) {
    return ToggleSettingCard(
      icon: icon,
      title: title,
      initialValue: initialValue,
      onChanged: onChanged,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      iconColor: iconColor,
      iconSize: iconSize,
    );
  }

  /// Factory constructor for creating toggle card with SVG asset
  factory ToggleSettingCard.withSvg({
    required String svgAsset,
    required String title,
    bool initialValue = false,
    ValueChanged<bool>? onChanged,
    Color? activeColor,
    Color? inactiveColor,
    Color? iconColor,
    double? iconSize,
  }) {
    return ToggleSettingCard(
      svgAsset: svgAsset,
      title: title,
      initialValue: initialValue,
      onChanged: onChanged,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      iconColor: iconColor,
      iconSize: iconSize,
    );
  }

  /// Helper method to check if this toggle card uses SVG
  bool get isSvg => svgAsset != null;

  /// Helper method to check if this toggle card uses IconData
  bool get isIcon => icon != null;

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

  /// Build the appropriate icon widget based on the widget type
  /// Returns either an Icon widget for IconData or SvgPicture for SVG assets
  Widget _buildIcon() {
    final size = widget.iconSize ?? 16.0;
    final color = widget.iconColor ?? Colors.black;

    if (widget.isSvg) {
      return SvgPicture.asset(
        widget.svgAsset!,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    } else {
      return Icon(widget.icon!, size: size, color: color);
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
          _buildIcon(),
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
            activeColor: SettingsConstants.primaryGreen,
            inactiveColor: widget.inactiveColor ?? Colors.grey.shade300,
            toggleColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
