import 'package:cross_chat_app/app/controllers/settings_controller.dart';
import 'package:cross_chat_app/app/services/database_service.dart';
import 'package:cross_chat_app/app/ui/pages/settings/widgets/database_connection_form.dart';
import 'package:cross_chat_app/app/ui/pages/settings/widgets/settings_group.dart';
import 'package:cross_chat_app/app/ui/pages/settings/widgets/settings_item.dart';
import 'package:cross_chat_app/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text('Settings', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 32)),
              const SizedBox(height: 32),

              // --- Database Connection Section ---
              Obx(() => SettingsGroup(
                    title: 'Data Source',
                    children: [ _buildDatabaseStatusWidget() ],
                  )),

              // --- Account Section (RE-ADDED) ---
              SettingsGroup(
                title: 'Account & Privacy',
                children: [
                  SettingsItem(
                    icon: Icons.person_outline_rounded,
                    title: 'Edit Profile',
                    subtitle: 'Update your name, photo, and status',
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                   Obx(
                    () => SettingsItem(
                      icon: Icons.visibility_outlined,
                      title: 'Show Online Status',
                      trailing: Switch(
                        value: controller.showOnlineStatus.value,
                        onChanged: controller.toggleOnlineStatus,
                      ),
                    ),
                  ),
                ],
              ),
              
              // --- Notifications Section (RE-ADDED) ---
              SettingsGroup(
                title: 'Notifications',
                children: [
                  Obx(
                    () => SettingsItem(
                      icon: Icons.notifications_active_outlined,
                      title: 'Desktop Notifications',
                      trailing: Switch(
                        value: controller.enableNotifications.value,
                        onChanged: controller.toggleNotifications,
                      ),
                    ),
                  ),
                  Obx(
                    () => SettingsItem(
                      icon: Icons.music_note_rounded,
                      title: 'Message Sounds',
                      trailing: Switch(
                        value: controller.enableMessageSounds.value,
                        onChanged: controller.enableNotifications.value
                            ? controller.toggleMessageSounds
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
              
              // --- Data Section (RE-ADDED) ---
              SettingsGroup(
                title: 'Data & Storage',
                children: [
                  SettingsItem(
                    icon: Icons.delete_sweep_rounded,
                    title: 'Clear Cache',
                    subtitle: 'Free up space by removing temporary files',
                    onTap: controller.clearCache,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatabaseStatusWidget() {
    final status = controller.connectionStatus.value;
    final dbType = Get.find<DatabaseService>().currentDb;

    if (status == ConnectionStatus.connected) {
      return SettingsItem(
        icon: Icons.cloud_done_rounded,
        title: 'Connected to ${dbType.name.capitalizeFirst}',
        subtitle: 'Your data is being synced.',
        trailing: TextButton(
          onPressed: controller.disconnectFromDatabase,
          child: const Text('Disconnect', style: TextStyle(color: Colors.redAccent)),
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: DatabaseConnectionForm(),
      );
    }
  }
}