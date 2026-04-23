import 'package:flutter/material.dart';
import '../../../../core/ui/urban_theme.dart';
import 'theme_settings_screen.dart';

/// Экран настроек приложения
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UrbanTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Настройки', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingsItem(
            context,
            icon: Icons.palette_outlined,
            title: 'Цветовая схема',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ThemeSettingsScreen()),
              );
            },
          ),
          _buildSettingsItem(
            context,
            icon: Icons.notifications_none_outlined,
            title: 'Уведомления',
            onTap: () {},
          ),
          _buildSettingsItem(
            context,
            icon: Icons.lock_outline,
            title: 'Конфиденциальность',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: UrbanTheme.primaryColor),
      title: Text(title, style: UrbanTheme.bodyLarge),
      trailing: const Icon(Icons.chevron_right, color: UrbanTheme.textMuted),
      onTap: onTap,
    );
  }
}
