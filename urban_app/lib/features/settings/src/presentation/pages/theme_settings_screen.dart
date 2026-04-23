import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_app/core/ui/urban_theme.dart';
import 'package:urban_app/features/settings/src/presentation/bloc/theme_bloc.dart';
import 'package:urban_app/features/settings/src/presentation/bloc/theme_event.dart';
import 'package:urban_app/features/settings/src/presentation/bloc/theme_state.dart';

/// Экран настройки тем (Светлая / Темная)
class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

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
            title: Text(
              'Цветовая схема', 
              style: UrbanTheme.headingSmall(context).copyWith(color: textColor),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: textColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildThemeOption(
                context, 
                ThemeMode.light, 
                'Светлая тема', 
                Icons.light_mode_outlined,
                state,
              ),
              const SizedBox(height: 8),
              _buildThemeOption(
                context, 
                ThemeMode.dark, 
                'Темная тема', 
                Icons.dark_mode_outlined,
                state,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context, 
    ThemeMode mode, 
    String label, 
    IconData icon,
    ThemeState currentState,
  ) {
    final isSelected = currentState.themeMode == mode;
    final isDark = currentState.themeMode == ThemeMode.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: UrbanTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: UrbanTheme.primaryColor, width: 2) : null,
      ),
      child: ListTile(
        onTap: () {
          context.read<ThemeBloc>().add(ChangeThemeEvent(
            themeMode: mode,
          ));
        },
        leading: Icon(
          icon, 
          color: isSelected ? UrbanTheme.primaryColor : UrbanTheme.getTextSecondary(context),
        ),
        title: Text(
          label, 
          style: UrbanTheme.bodyLarge(context).copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: isSelected 
          ? const Icon(Icons.check_circle, color: UrbanTheme.primaryColor)
          : null,
      ),
    );
  }
}
