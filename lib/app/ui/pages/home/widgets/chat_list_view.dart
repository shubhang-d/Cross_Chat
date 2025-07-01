import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cross_chat_app/app/controllers/home_controller.dart'; // Change your_app_name
import 'chat_list_item.dart';

class ChatListView extends GetView<HomeController> {
  const ChatListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.chats.length,
        itemBuilder: (context, index) {
          final chat = controller.chats[index];
          return ChatListItem(chat: chat, index: index);
        },
      ),
    );
  }
}