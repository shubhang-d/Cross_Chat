import 'package:cross_chat_app/app/data/models/chat_model.dart';
import 'package:cross_chat_app/app/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final Chat chat;
  ChatController({required this.chat});

  final RxList<Message> messages = <Message>[].obs;
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final RxBool isTyping = false.obs;

  // Let's define the current user's ID
  final String currentUserId = 'me';

  @override
  void onInit() {
    super.onInit();
    // Listen to text field changes to enable/disable the send button
    textController.addListener(() {
      isTyping.value = textController.text.isNotEmpty;
    });
    fetchMessages();
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void sendMessage() {
    if (textController.text.isEmpty) return;

    final newMessage = Message(
      text: textController.text,
      timestamp: '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}',
      senderId: currentUserId,
      isSentByMe: true,
    );
    
    // Process messages to update group styling before adding
    _processAndAddMessage(newMessage);
    
    textController.clear();
    _scrollToBottom();
  }
  
  void _processAndAddMessage(Message message) {
    if (messages.isNotEmpty) {
      final lastMessage = messages.first;
      // If the last message was from the same sender, it's no longer the last in its group
      if (lastMessage.senderId == message.senderId) {
        messages[0] = lastMessage.copyWith(isLastInGroup: false);
      }
    }
    messages.insert(0, message); // Insert at the beginning for reversed list
  }

  void fetchMessages() {
    // In a real app, this would be an API call for this specific chat.
    // The list is "reversed" chronologically for use in a reversed ListView.
    var dummyMessages = [
      Message(text: 'The new design looks amazing! 😍', timestamp: '1 day ago', senderId: chat.name, isSentByMe: false),
      Message(text: 'Thanks! I just pushed the final changes.', timestamp: '1 day ago', senderId: currentUserId, isSentByMe: true),
      Message(text: 'Can you review my latest PR?', timestamp: '11:10', senderId: 'Mike Johnson', isSentByMe: false),
      Message(text: 'Sure, I\'ll take a look now.', timestamp: '11:11', senderId: currentUserId, isSentByMe: true),
      Message(text: 'Looks good to merge.', timestamp: '11:15', senderId: currentUserId, isSentByMe: true),
      Message(text: 'Awesome, thanks!', timestamp: '11:16', senderId: 'Mike Johnson', isSentByMe: false),
      Message(text: 'Sounds good! See you then.', timestamp: '14:55', senderId: 'Sarah Smith', isSentByMe: false),
      Message(text: 'Hey, how is the Flutter app coming?', timestamp: '15:32', senderId: 'Jane Doe', isSentByMe: false),
      Message(text: 'It\'s going great! Just finishing up the chat UI.', timestamp: '15:33', senderId: currentUserId, isSentByMe: true),
      Message(text: 'Want a sneak peek?', timestamp: '15:33', senderId: currentUserId, isSentByMe: true),
    ]
    .where((m) => m.senderId == chat.name || m.isSentByMe)
    .toList()
    .reversed // Reverse to get chronological order for processing
    .toList();

    messages.assignAll(_processMessageGroups(dummyMessages).reversed);
  }
  
  // This powerful helper function adds the 'isLastInGroup' flag
  List<Message> _processMessageGroups(List<Message> messages) {
    if (messages.isEmpty) return [];
    
    List<Message> processed = [];
    for (int i = 0; i < messages.length; i++) {
      bool isLast = (i == messages.length - 1) || (messages[i].senderId != messages[i + 1].senderId);
      processed.add(messages[i].copyWith(isLastInGroup: isLast));
    }
    return processed;
  }
  
  void _scrollToBottom() {
    // A small delay ensures the frame has rendered before scrolling
    Future.delayed(const Duration(milliseconds: 50), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}