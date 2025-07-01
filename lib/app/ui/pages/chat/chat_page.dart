import 'package:cross_chat_app/app/controllers/chat_controller.dart';
import 'package:cross_chat_app/app/data/models/chat_model.dart';
import 'package:cross_chat_app/app/ui/pages/chat/widgets/chat_header.dart';
import 'package:cross_chat_app/app/ui/pages/chat/widgets/message_bubble.dart';
import 'package:cross_chat_app/app/ui/pages/chat/widgets/message_composer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  final Chat chat;
  const ChatPage({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController(chat: chat), tag: chat.name);

    return Scaffold(
      appBar: ChatHeader(chat: chat),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: controller.scrollController,
                reverse: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return MessageBubble(message: message);
                },
              ),
            ),
          ),
          // Pass the controller instance directly here
          MessageComposer(controller: controller),
        ],
      ),
    );
  }
}