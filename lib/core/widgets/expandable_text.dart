
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  final TextStyle? style;

  const ExpandableText({
    super.key,
    required this.text,
     this.style,
    this.maxLines = 2,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;
  late String _truncatedText;
  bool _isOverflowing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkOverflow();
  }

  void _checkOverflow() {
    final style = widget.style ?? Theme.of(context).textTheme.bodyMedium!;
    final tp = TextPainter(
      text: TextSpan(text: widget.text, style: style),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);

    if (tp.didExceedMaxLines) {
      _isOverflowing = true;

      // Now manually truncate the text to approximate fitting text
      final words = widget.text.split(' ');
      String visibleText = '';
      for (int i = 0; i < words.length; i++) {
        final current = (visibleText + ' ' + words[i]).trim();
        final testTp = TextPainter(
          text: TextSpan(text: '$current...', style: style),
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: MediaQuery.of(context).size.width);
        if (testTp.didExceedMaxLines) break;
        visibleText = current;
      }

      _truncatedText = visibleText;
    } else {
      _isOverflowing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = widget.style ?? Theme.of(context).textTheme.bodyMedium!;
    final linkStyle = defaultStyle.copyWith(color: Colors.orange, fontWeight: FontWeight.w500);

    if (!_isOverflowing) {
      return Text(widget.text, style: defaultStyle);
    }

    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: RichText(
        text: TextSpan(
          style: defaultStyle,
          children: [
            TextSpan(
              text: _isExpanded ? widget.text : '$_truncatedText... ',
            ),
            TextSpan(
              text: _isExpanded ? 'Show Less' : 'Read More',
              style: linkStyle,
            ),
          ],
        ),
      ),
    );
  }
}