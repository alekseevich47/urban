import 'package:flutter/material.dart';
import '../theme/urban_theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urban',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: UrbanTheme.backgroundColor,
        primaryColor: UrbanTheme.primaryColor,
        colorScheme: const ColorScheme.dark(
          primary: UrbanTheme.primaryColor,
          secondary: UrbanTheme.secondaryColor,
          surface: UrbanTheme.surfaceColor,
        ),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MapScreenPlaceholder(),
    const FeedScreenPlaceholder(),
    const ChatScreenPlaceholder(),
    const ProfileScreenPlaceholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: UrbanTheme.surfaceColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.map_outlined, Icons.map, 'Карта'),
                _buildNavItem(1, Icons.explore_outlined, Icons.explore, 'Лента'),
                _buildNavItem(2, Icons.chat_outlined, Icons.chat, 'Чат'),
                _buildNavItem(3, Icons.person_outline, Icons.person, 'Профиль'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData inactiveIcon, IconData activeIcon, String label) {
    final isActive = _currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? UrbanTheme.primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : inactiveIcon,
              color: isActive ? UrbanTheme.primaryColor : UrbanTheme.textMuted,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: UrbanTheme.bodySmall.copyWith(
                color: isActive ? UrbanTheme.primaryColor : UrbanTheme.textMuted,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Заглушки для экранов (будут заменены на реальные экраны)
class MapScreenPlaceholder extends StatelessWidget {
  const MapScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.map, size: 64, color: UrbanTheme.primaryColor),
          SizedBox(height: 16),
          Text('Экран карты', style: UrbanTheme.headingMedium),
          SizedBox(height: 8),
          Text('Здесь будет интерактивная карта с развлечениями', style: UrbanTheme.bodyMedium),
        ],
      ),
    );
  }
}

class FeedScreenPlaceholder extends StatelessWidget {
  const FeedScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.explore, size: 64, color: UrbanTheme.secondaryColor),
          SizedBox(height: 16),
          Text('Лента развлечений', style: UrbanTheme.headingMedium),
          SizedBox(height: 8),
          Text('Фото и отзывы от других пользователей', style: UrbanTheme.bodyMedium),
        ],
      ),
    );
  }
}

class ChatScreenPlaceholder extends StatelessWidget {
  const ChatScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat, size: 64, color: UrbanTheme.accentColor),
          SizedBox(height: 16),
          Text('Сообщения', style: UrbanTheme.headingMedium),
          SizedBox(height: 8),
          Text('Общайтесь с друзьями и организаторами', style: UrbanTheme.bodyMedium),
        ],
      ),
    );
  }
}

class ProfileScreenPlaceholder extends StatelessWidget {
  const ProfileScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 64, color: UrbanTheme.warningColor),
          SizedBox(height: 16),
          Text('Профиль', style: UrbanTheme.headingMedium),
          SizedBox(height: 8),
          Text('Ваша статистика, достижения и настройки', style: UrbanTheme.bodyMedium),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MainApp());
}
