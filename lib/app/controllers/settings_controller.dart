import 'package:cross_chat_app/app/services/database_service.dart';
import 'package:cross_chat_app/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
   final DatabaseService _dbService = Get.find();

  // --- GENERAL UI STATE ---
  final RxBool enableNotifications = true.obs;
  final RxBool enableMessageSounds = true.obs;
  final RxBool showOnlineStatus = true.obs;

  // --- DATABASE CONNECTION STATE (Proxy to the service) ---
  // The controller now gets the state directly from the service.
  // The UI can still do `controller.connectionStatus.value` and it will be reactive.
  Rx<ConnectionStatus> get connectionStatus => _dbService.connectionStatus;
  RxString get connectionError => _dbService.connectionError;

  final Rx<DatabaseType> selectedDatabase = DatabaseType.none.obs;
  
  // Form controllers
  final firebaseProjectIdController = TextEditingController();
  final supabaseUrlController = TextEditingController();
  final supabaseAnonKeyController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _dbService.initialize();
  }
  
  // --- DATABASE ACTIONS ---
  void selectDatabaseType(DatabaseType? type) {
    if (type != null) {
      selectedDatabase.value = type;
    }
  }
  
  Future<void> connectToDatabase() async {
    final type = selectedDatabase.value;
    if (type == DatabaseType.none) return;

    Map<String, String> credentials = {};
    if (type == DatabaseType.firebase) {
      if (firebaseProjectIdController.text.isEmpty) {
        connectionError.value = "Firebase Project ID cannot be empty.";
        connectionStatus.value = ConnectionStatus.error;
        return;
      }
      credentials['project_id'] = firebaseProjectIdController.text;
    } else if (type == DatabaseType.supabase) {
       if (supabaseUrlController.text.isEmpty || supabaseAnonKeyController.text.isEmpty) {
        connectionError.value = "Supabase URL and Key cannot be empty.";
        connectionStatus.value = ConnectionStatus.error;
        return;
      }
      credentials['url'] = supabaseUrlController.text;
      credentials['anon_key'] = supabaseAnonKeyController.text;
    }

    await _dbService.connect(type, credentials);
  }

  Future<void> disconnectFromDatabase() async {
    firebaseProjectIdController.clear();
    supabaseUrlController.clear();
    supabaseAnonKeyController.clear();
    selectedDatabase.value = DatabaseType.none;
    await _dbService.disconnect();
  }

  // --- GENERAL SETTINGS ACTIONS (ADDED BACK) ---
  void toggleNotifications(bool value) {
    enableNotifications.value = value;
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