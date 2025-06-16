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
            Icons.thumb_up,
            color: isLiked ? Colors.green : Colors.grey,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: onDislikePressed,
          child: Icon(
            Icons.thumb_down,
            color: isDisliked ? Colors.red : Colors.grey,
            size: 24,
          ),
        ),
      ],
    );
  }
}
