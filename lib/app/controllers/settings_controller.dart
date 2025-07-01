import 'package:cross_chat_app/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  // --- STATE ---
  // Use RxBool for reactive switches
  final RxBool enableNotifications = true.obs;
  final RxBool enableMessageSounds = true.obs;
  final RxBool showOnlineStatus = true.obs;
  
  // --- ACTIONS ---
  void toggleNotifications(bool value) {
    enableNotifications.value = value;
    // If master switch is off, turn off sub-switches
    if (!value) {
      enableMessageSounds.value = false;
    }
  }

  void toggleMessageSounds(bool value) {
    enableMessageSounds.value = value;
  }

  void toggleOnlineStatus(bool value) {
    showOnlineStatus.value = value;
  }
  
  void clearCache() {
    // In a real app, you'd perform a cache clearing operation here.
    // For now, we'll just show a confirmation snackbar.
    Get.snackbar(
      "Cache Cleared",
      "Temporary application data has been removed.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.accentPanel,
      colorText: AppColors.textPrimary,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
    );
  }
}