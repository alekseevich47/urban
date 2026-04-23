import 'package:flutter/material.dart';
import '../../../../core/ui/urban_theme.dart';

/// Экран выбора цветовой схемы
class ThemeSettingsScreen extends StatefulWidget {
  const ThemeSettingsScreen({super.key});

  @override
  State<ThemeSettingsScreen> createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  // Текущий выбор (по умолчанию Системная)
  int _selectedThemeIndex = 2; 

  // Пользовательские цвета (заглушка)
  Color _primaryUserColor = UrbanTheme.primaryColor;
  Color _accentUserColor = UrbanTheme.accentColor;

  final List<String> _themes = [
    'Светлая',
    'Темная',
    'Системная',
    'Пользовательская',
  ];

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
        title: const Text('Цветовая схема', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(_themes.length, (index) => _buildThemeOption(index)),
            
            if (_selectedThemeIndex == 3) ...[
              const SizedBox(height: 32),
              Text('Настройка цветов', style: UrbanTheme.headingSmall),
              const SizedBox(height: 16),
              _buildColorPickerItem('Основной цвет', _primaryUserColor, (color) {
                setState(() => _primaryUserColor = color);
              }),
              _buildColorPickerItem('Дополнительный цвет', _accentUserColor, (color) {
                setState(() => _accentUserColor = color);
              }),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(int index) {
    final isSelected = _selectedThemeIndex == index;
    return ListTile(
      onTap: () => setState(() => _selectedThemeIndex = index),
      leading: isSelected 
          ? const Icon(Icons.check_circle, color: UrbanTheme.primaryColor)
          : const Icon(Icons.circle_outlined, color: UrbanTheme.textMuted),
      title: Text(
        _themes[index],
        style: UrbanTheme.bodyLarge.copyWith(
          color: isSelected ? UrbanTheme.primaryColor : UrbanTheme.textPrimary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildColorPickerItem(String label, Color currentColor, Function(Color) onColorSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: UrbanTheme.bodyMedium),
          GestureDetector(
            onTap: () {
              // Здесь в будущем будет вызов ColorPicker
              // Пока просто имитируем выбор, меняя яркость
              onColorSelected(currentColor.withValues(alpha: 0.8));
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: currentColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: currentColor.withValues(alpha: 0.4),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
