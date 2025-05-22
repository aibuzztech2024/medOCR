import 'package:avatar/core/widgets/width_box.dart';
import 'package:flutter/material.dart';

/// A reusable widget that places two widgets horizontally:
/// one expandable and one fixed-size, with an option to manage their order.
///
/// Typically used for placing an input field with a trailing button or icon.
class InputWithAction extends StatelessWidget {
  /// The widget that takes up the remaining horizontal space.
  final Widget expandedChild;

  /// The fixed-size widget shown on one side.
  final Widget trailingChild;

  /// If true, the expandable widget appears first; otherwise, the fixed widget appears first.
  final bool expandedFirst;

  const InputWithAction({
    super.key,
    required this.expandedChild,
    required this.trailingChild,
    this.expandedFirst = true,
  });

  @override
  Widget build(BuildContext context) {
    final expanded = Expanded(child: expandedChild);
    final fixed = SizedBox.fromSize(
      size: const Size(75, 52),
      child: Center(child: trailingChild),
    );

    return Row(
      children:
          expandedFirst
              ? [expanded, WidthBox(10), fixed]
              : [fixed, WidthBox(10), expanded],
    );
  }
}
