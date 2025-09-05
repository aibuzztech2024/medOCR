import 'package:flutter/material.dart';

class FeedbackButtonsWidget extends StatelessWidget {
  final bool isLiked;
  final bool isDisliked;
  final VoidCallback onLikePressed;
  final VoidCallback onDislikePressed;

  const FeedbackButtonsWidget({
    Key? key,
    required this.isLiked,
    required this.isDisliked,
    required this.onLikePressed,
    required this.onDislikePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onLikePressed,
          child: Icon(
            Icons.thumb_up_alt_outlined,
            color: isLiked ? Colors.green : Colors.black45,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: onDislikePressed,
          child: Icon(
            Icons.thumb_down_alt_outlined,
            color: isDisliked ? Colors.red : Colors.black45,
            size: 24,
          ),
        ),
      ],
    );
  }
}
