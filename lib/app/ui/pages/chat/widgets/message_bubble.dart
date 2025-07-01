import 'package:cross_chat_app/app/data/models/message_model.dart';
import 'package:cross_chat_app/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSentByMe = message.isSentByMe;
    final isLastInGroup = message.isLastInGroup;

    // Define corner radius based on message grouping
    final bubbleRadius = isSentByMe
        ? BorderRadius.only(
            topLeft: const Radius.circular(18),
            bottomLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomRight: isLastInGroup ? const Radius.circular(4) : const Radius.circular(18),
          )
        : BorderRadius.only(
            topLeft: isLastInGroup ? const Radius.circular(4) : const Radius.circular(18),
            bottomLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomRight: const Radius.circular(18),
          );

    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        margin: EdgeInsets.only(
          top: 2,
          bottom: 2,
          left: isSentByMe ? 0 : 12,
          right: isSentByMe ? 12 : 0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSentByMe ? AppColors.primary : AppColors.accentPanel,
          borderRadius: bubbleRadius,
        ),
        child: Text(
          message.text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isSentByMe ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    )
    .animate()
    .fadeIn(duration: 300.ms, curve: Curves.easeOut)
    .slideX(begin: isSentByMe ? 0.2 : -0.2, curve: Curves.easeOut);
  }
}