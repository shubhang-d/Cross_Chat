import 'package:cross_chat_app/app/data/models/chat_model.dart';
import 'package:cross_chat_app/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget implements PreferredSizeWidget {
  final Chat chat;
  const ChatHeader({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.background, width: 1.0)),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(chat.avatarUrl), radius: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(chat.name, style: Theme.of(context).textTheme.titleMedium),
              if (chat.isOnline)
                Text(
                  'Online',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.primary),
                ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam_rounded),
            splashRadius: 20,
            tooltip: 'Video Call',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call_rounded),
            splashRadius: 20,
            tooltip: 'Audio Call',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
            splashRadius: 20,
            tooltip: 'More',
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}