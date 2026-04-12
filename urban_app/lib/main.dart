import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'theme/urban_theme.dart';
import 'screens/map_screen.dart';
import 'screens/feed_screen.dart';
import 'features/venues/data/repositories/venue_repository_impl.dart';
import 'features/venues/domain/use_cases/get_venues_use_case.dart';
import 'features/venues/presentation/bloc/venue_bloc.dart';
import 'features/venues/presentation/bloc/venue_event.dart';

/// Точка входа в приложение Urban.
/// Инициализирует провайдеры и запускает корневой виджет.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Загружаем переменные окружения (.env)
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // В продакшене здесь должно быть логирование через logger
    debugPrint('Ошибка загрузки .env: $e');
  }

  // Инициализация зависимостей для Venues (в будущем через get_it)
  final venueRepository = VenueRepositoryImpl();
  final getVenuesUseCase = GetVenuesUseCase(venueRepository);

  runApp(
    // Внедряем VenueBloc (Clean Architecture) через BlocProvider
    BlocProvider(
      create: (_) => VenueBloc(getVenuesUseCase: getVenuesUseCase)
        ..add(const FetchVenuesEvent()),
      child: const MainApp(),
    ),
  );
}

/// Основной класс приложения.
/// Настраивает глобальную тему и стартовый экран.
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

/// Главный экран с нижней навигацией.
/// Управляет переключением между картой, лентой, чатами и профилем.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  /// Список экранов для навигации.
  final List<Widget> _screens = const [
    MapScreen(),
    FeedScreen(),
    ChatScreenPlaceholder(),
    ProfileScreenPlaceholder(),
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

  /// Строит элемент нижней навигации с анимацией.
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

/// Заглушка для экрана чатов.
class ChatScreenPlaceholder extends StatelessWidget {
  const ChatScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Чат (в разработке)',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

/// Заглушка для экрана профиля.
class ProfileScreenPlaceholder extends StatelessWidget {
  const ProfileScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Профиль (в разработке)',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
