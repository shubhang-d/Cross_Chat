import 'package:cross_chat_app/app/controllers/chat_controller.dart';
import 'package:cross_chat_app/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Keep GetX for Obx

class MessageComposer extends StatelessWidget { // Changed from GetView
  final ChatController controller; // Add this line

  // Modify the constructor to require the controller
  const MessageComposer({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The rest of the build method remains EXACTLY the same!
    // The `controller.` calls will now work perfectly because we have a direct reference.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.background, width: 1.0)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_circle_outline_rounded),
              splashRadius: 20,
              tooltip: 'Attach File',
            ),
            Expanded(
              child: TextField(
                controller: controller.textController,
                onSubmitted: (_) => controller.sendMessage(),
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Obx(
              () => IconButton(
                onPressed: controller.isTyping.value ? controller.sendMessage : null,
                icon: const Icon(Icons.send_rounded),
                color: AppColors.primary,
                splashRadius: 20,
                tooltip: 'Send Message',
              ),
            ),
          ],
        ),
      ),
    );
  }
}