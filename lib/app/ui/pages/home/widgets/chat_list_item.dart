import 'package:cross_chat_app/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:cross_chat_app/app/controllers/home_controller.dart';
import 'package:cross_chat_app/app/data/models/chat_model.dart';

class ChatListItem extends StatefulWidget {
  final Chat chat;
  final int index;
  const ChatListItem({Key? key, required this.chat, required this.index}) : super(key: key);

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  bool _isHovered = false;
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedChatIndex.value == widget.index;
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => controller.selectChat(widget.index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.accentPanel : (_isHovered ? AppColors.background : Colors.transparent),
              borderRadius: BorderRadius.circular(8),
              // Add a subtle border on the left when selected
              border: Border(
                left: BorderSide(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  width: 3,
                ),
              ),
            ),
            child: Row(
              children: [
                _buildAvatar(),
                const SizedBox(width: 12),
                // CHANGED: Restructured layout for a cleaner look
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.chat.name,
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            widget.chat.timestamp,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.chat.lastMessage,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (widget.chat.unreadCount > 0) ...[
                            const SizedBox(width: 8),
                            _buildUnreadIndicator(widget.chat.unreadCount),
                          ],
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
    // Keep the awesome staggered entrance animation
    // .animate()
    // .fadeIn(duration: 400.ms, curve: Curves.easeOut)
    // .slideY(begin: 0.2, duration: 400.ms, curve: Curves.easeOut)
    // .delay((100 * widget.index).ms);
  }
  
  Widget _buildUnreadIndicator(int count) {
    return Container(
      height: 20,
      width: 20,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$count',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(widget.chat.avatarUrl),
        ),
        if (widget.chat.isOnline)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                color: const Color(0xFF3BA55D), // A nice, standard "online" green
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.accentPanel, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}