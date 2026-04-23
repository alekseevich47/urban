import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_app/core/ui/urban_theme.dart';
import 'package:urban_app/features/settings/src/presentation/bloc/theme_bloc.dart';
import 'package:urban_app/features/settings/src/presentation/bloc/theme_state.dart';
import 'package:urban_app/features/settings/src/presentation/pages/theme_settings_screen.dart';

/// Экран настроек приложения
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeMode == ThemeMode.dark;
        final backgroundColor = UrbanTheme.getBackgroundColor(context);
        final textColor = UrbanTheme.getTextPrimary(context);
        
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: textColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Настройки', 
              style: UrbanTheme.headingSmall(context).copyWith(color: textColor),
            ),
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
                  // Используем CupertinoPageRoute для более плавного перехода без "вспышек"
                  Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => const ThemeSettingsScreen()),
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
      },
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
      title: Text(
        title, 
        style: UrbanTheme.bodyLarge(context),
      ),
      trailing: Icon(
        Icons.chevron_right, 
        color: UrbanTheme.getTextSecondary(context),
      ),
      onTap: onTap,
    );
  }
}
