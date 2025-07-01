import 'package:cross_chat_app/app/controllers/home_controller.dart'; // Import controller
import 'package:cross_chat_app/app/ui/pages/chat/chat_page.dart';     // Import ChatPage
import 'package:cross_chat_app/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'widgets/chat_list_view.dart';
import 'widgets/sidebar.dart';

// Make it a GetView to access the controller
class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Container(
            width: 350,
            color: AppColors.surface,
            child: Column(
              children: [
                _buildChatListHeader(),
                const Expanded(child: ChatListView()),
              ],
            ),
          ),

          // --- MODIFICATION START ---
          // Pane 3: Main Chat View (Now Dynamic)
          Expanded(
            child: Obx(() {
              // Check if a chat is selected
              final selectedIndex = controller.selectedChatIndex.value;
              if (selectedIndex >= 0 && selectedIndex < controller.chats.length) {
                final selectedChat = controller.chats[selectedIndex];
                // Use a ValueKey to ensure Flutter rebuilds the ChatPage
                // and its controller when the user switches chats.
                return ChatPage(
                  key: ValueKey(selectedChat.name), // CRUCIAL for state management
                  chat: selectedChat,
                );
              } else {
                // Show the placeholder if no chat is selected
                return _buildPlaceholder();
              }
            }),
          )
          // --- MODIFICATION END ---
        ],
      ),
    );
  }

  // Extracted the placeholder to a separate method for cleanliness
  Widget _buildPlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: AppColors.background, width: 1.0)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.message_rounded, size: 80, color: AppColors.accentPanel),
            const SizedBox(height: 20),
            Text(
              'Select a chat to start messaging',
              style: Get.theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatListHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search, size: 20),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_comment_rounded),
            color: AppColors.textSecondary,
            splashRadius: 20,
            tooltip: 'New Chat',
          ),
        ],
      ),
    );
  }
}