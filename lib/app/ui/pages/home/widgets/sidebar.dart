import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cross_chat_app/app/controllers/home_controller.dart';
import 'package:cross_chat_app/app/ui/theme/app_theme.dart';

class Sidebar extends GetView<HomeController> {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      color: AppColors.background, // Use darkest color for the sidebar
      child: Column(
        children: [
          const SizedBox(height: 20),
          // A more abstract logo
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.bolt, color: Colors.white, size: 28),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Column(
              children: [
                _buildNavIcon(
                  icon: Icons.chat_bubble_rounded,
                  tooltip: 'Chats',
                  index: 0,
                ),
                _buildNavIcon(
                  icon: Icons.people_alt_rounded,
                  tooltip: 'Contacts',
                  index: 1,
                ),
                _buildNavIcon(
                  icon: Icons.settings_rounded,
                  tooltip: 'Settings',
                  index: 2,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=10'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavIcon({
    required IconData icon,
    required String tooltip,
    required int index,
  }) {
    return Obx(
      () {
        final isSelected = controller.selectedNavIndex.value == index;
        return Tooltip(
          message: tooltip,
          textStyle: const TextStyle(color: Colors.white),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(5)
          ),
          child: GestureDetector(
            onTap: () => controller.selectNavItem(index),
            child: Container(
              height: 70,
              width: 80,
              // Use a Stack to overlay the selection indicator
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // The animated selection pill indicator
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    height: isSelected ? 40 : 0,
                    width: 5,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    margin: const EdgeInsets.only(right: 75), // Aligns to the left edge
                  ),
                  Icon(
                    icon,
                    color: isSelected
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}