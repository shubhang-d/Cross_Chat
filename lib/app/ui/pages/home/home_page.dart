import 'package:cross_chat_app/app/controllers/home_controller.dart';
import 'package:cross_chat_app/app/ui/pages/chat/chat_page.dart';
import 'package:cross_chat_app/app/ui/pages/settings/settings_page.dart'; // Import SettingsPage
import 'package:cross_chat_app/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/chat_list_view.dart';
import 'widgets/sidebar.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),

          // --- MODIFICATION START ---
          // This Expanded widget will now build its child based on the selected nav item.
          Expanded(
            child: Obx(() {
              // Show SettingsPage if the settings icon (index 2) is selected
              if (controller.selectedNavIndex.value == 2) {
                return const SettingsPage();
              }
              // Otherwise, show the default chat layout
              else {
                return Row(
                  children: [
                    _buildChatListPane(),
                    _buildChatViewPane(),
                  ],
                );
              }
            }),
          ),
          // --- MODIFICATION END ---
        ],
      ),
    );
  }
  
  // Extracted chat list pane into its own method for clarity
  Widget _buildChatListPane() {
    return Container(
      width: 350,
      color: AppColors.surface,
      child: Column(
        children: [
          _buildChatListHeader(),
          const Expanded(child: ChatListView()),
        ],
      ),
    );
  }

  // Extracted chat view pane into its own method
  Widget _buildChatViewPane() {
    return Expanded(
      child: Obx(() {
        final selectedIndex = controller.selectedChatIndex.value;
        if (selectedIndex >= 0 && selectedIndex < controller.chats.length) {
          final selectedChat = controller.chats[selectedIndex];
          return ChatPage(
            key: ValueKey(selectedChat.name),
            chat: selectedChat,
          );
        } else {
          return _buildPlaceholder();
        }
      }),
    );
  }

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