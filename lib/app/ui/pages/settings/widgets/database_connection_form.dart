import 'package:cross_chat_app/app/controllers/settings_controller.dart';
import 'package:cross_chat_app/app/services/database_service.dart';
import 'package:cross_chat_app/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatabaseConnectionForm extends GetView<SettingsController> {
  const DatabaseConnectionForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDbSelection(),
        const SizedBox(height: 16),
        Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _buildFormFields(controller.selectedDatabase.value),
          ),
        ),
        const SizedBox(height: 16),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildDbSelection() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: _buildRadioTile(
              'Firebase',
              DatabaseType.firebase,
              controller.selectedDatabase.value,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildRadioTile(
              'Supabase',
              DatabaseType.supabase,
              controller.selectedDatabase.value,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRadioTile(String title, DatabaseType value, DatabaseType groupValue) {
    bool isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => controller.selectDatabaseType(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.accentPanel,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: 12),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields(DatabaseType type) {
    switch (type) {
      case DatabaseType.firebase:
        return Column(
          key: const ValueKey('firebase'),
          children: [
            TextField(
              controller: controller.firebaseProjectIdController,
              decoration: const InputDecoration(labelText: 'Firebase Project ID'),
            ),
          ],
        );
      case DatabaseType.supabase:
        return Column(
          key: const ValueKey('supabase'),
          children: [
            TextField(
              controller: controller.supabaseUrlController,
              decoration: const InputDecoration(labelText: 'Supabase Project URL'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.supabaseAnonKeyController,
              decoration: const InputDecoration(labelText: 'Supabase Anon Key'),
              obscureText: true,
            ),
          ],
        );
      default:
        return const SizedBox.shrink(key: ValueKey('none'));
    }
  }

  Widget _buildActionButtons() {
    return Obx(() {
      final status = controller.connectionStatus.value;
      if (status == ConnectionStatus.connecting) {
        return const Center(child: CircularProgressIndicator());
      }
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (status == ConnectionStatus.error)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                controller.connectionError.value,
                style: const TextStyle(color: Colors.redAccent),
                textAlign: TextAlign.center,
              ),
            ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: controller.selectedDatabase.value != DatabaseType.none
                ? controller.connectToDatabase
                : null,
            child: const Text('Connect'),
          ),
        ],
      );
    });
  }
}