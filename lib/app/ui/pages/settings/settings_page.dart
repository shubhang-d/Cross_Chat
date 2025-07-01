import 'package:cross_chat_app/app/controllers/settings_controller.dart';
import 'package:cross_chat_app/app/ui/pages/settings/widgets/settings_group.dart';
import 'package:cross_chat_app/app/ui/pages/settings/widgets/settings_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The main scaffold uses the surface color from our theme
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                'Settings',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 32),
              ),
              const SizedBox(height: 32),
              
              // --- Account Section ---
              SettingsGroup(
                title: 'Account',
                children: [
                  SettingsItem(
                    icon: Icons.person_outline_rounded,
                    title: 'Edit Profile',
                    subtitle: 'Update your name, photo, and status',
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                  SettingsItem(
                    icon: Icons.security_rounded,
                    title: 'Privacy and Security',
                    subtitle: 'Manage who can see your info',
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                ],
              ),
              
              // --- Notifications Section ---
              SettingsGroup(
                title: 'Notifications & Appearance',
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
                      // Disable this switch if the master notification switch is off
                      trailing: Switch(
                        value: controller.enableMessageSounds.value,
                        onChanged: controller.enableNotifications.value
                            ? controller.toggleMessageSounds
                            : null,
                      ),
                    ),
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
              
              // --- Data Section ---
              SettingsGroup(
                title: 'Data & Storage',
                children: [
                  SettingsItem(
                    icon: Icons.storage_rounded,
                    title: 'Manage Storage',
                    subtitle: 'View and clear stored media',
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
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
}