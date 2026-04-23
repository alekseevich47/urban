import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:urban_app/core/di/injection.dart';
import 'package:urban_app/core/ui/urban_theme.dart';
import 'package:urban_app/core/utils/logger.dart';
import 'package:urban_app/features/auth/src/presentation/pages/splash_screen.dart';
import 'package:urban_app/features/map/src/presentation/pages/map_screen.dart';
import 'package:urban_app/features/venues/venues.dart';
import 'package:urban_app/features/auth/auth.dart';
import 'package:urban_app/features/venues/src/domain/use_cases/get_venues_use_case.dart';
import 'package:urban_app/core/network/pocketbase_service.dart';
import 'package:urban_app/features/settings/src/presentation/bloc/theme_bloc.dart';
import 'package:urban_app/features/settings/src/presentation/bloc/theme_event.dart';
import 'package:urban_app/features/settings/src/presentation/bloc/theme_state.dart';

/// Точка входа в приложение Urban.
void main() async {
  // Удерживаем нативный сплэш до инициализации
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  UrbanLogger.i('Приложение запускается...');

  try {
    // 1. Загрузка переменных окружения (ОБЯЗАТЕЛЬНО ПЕРВЫМ ДЕЛОМ)
    UrbanLogger.i('Загрузка .env...');
    try {
      await dotenv.load(fileName: ".env");
      UrbanLogger.i('.env загружен');
    } catch (e) {
      UrbanLogger.w('Файл .env не найден. Используются дефолтные значения.');
    }

    // 2. Инициализация Dependency Injection
    UrbanLogger.i('Инициализация DI...');
    configureDependencies();
    UrbanLogger.i('DI инициализирован успешно');

    // 3. Инициализация сетевого слоя
    final pbUrl = dotenv.env['POCKETBASE_URL'] ?? dotenv.env['API_BASE_URL'];
    PocketBaseService.init(customUrl: pbUrl);
    UrbanLogger.i('PocketBaseService инициализирован на ${PocketBaseService.baseUrl}');

    // Проверка критической зависимости
    if (!getIt.isRegistered<GetVenuesUseCase>()) {
      throw Exception('GetVenuesUseCase не зарегистрирован в DI!');
    }

  } catch (e, stack) {
    UrbanLogger.e('Критическая ошибка при инициализации', error: e, stackTrace: stack);
    runApp(MaterialApp(home: Scaffold(body: Center(child: Text('Ошибка запуска: $e')))));
    return;
  }

  runApp(const MainApp());
}

/// Основной класс приложения.
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _showSplash = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => VenueBloc(getVenuesUseCase: getIt<GetVenuesUseCase>())
            ..add(const FetchVenuesEvent()),
        ),
        BlocProvider(
          create: (_) => getIt<ThemeBloc>()..add(LoadThemeEvent()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Urban',
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
              primaryColor: UrbanTheme.primaryColor,
              colorScheme: ColorScheme.fromSeed(
                seedColor: UrbanTheme.primaryColor,
                brightness: Brightness.light,
              ),
              fontFamily: 'Inter',
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: UrbanTheme.darkBackground,
              primaryColor: UrbanTheme.primaryColor,
              colorScheme: ColorScheme.fromSeed(
                seedColor: UrbanTheme.primaryColor,
                brightness: Brightness.dark,
                surface: UrbanTheme.darkSurface,
              ),
              fontFamily: 'Inter',
              useMaterial3: true,
            ),
            home: _showSplash 
                ? UrbanSplashScreen(onComplete: () => setState(() => _showSplash = false))
                : const HomeScreen(),
          );
        },
      ),
    );
  }
}

/// Главный экран с нижней навигацией.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    FeedScreen(),
    MapScreen(),
    ChatScreenPlaceholder(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeMode == ThemeMode.dark;
        
        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: isDark ? UrbanTheme.darkSurface : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
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
                    _buildNavItem(0, Icons.explore_outlined, Icons.explore, 'Лента', isDark),
                    _buildNavItem(1, Icons.map_outlined, Icons.map, 'Карта', isDark),
                    _buildNavItem(2, Icons.chat_outlined, Icons.chat, 'Чат', isDark),
                    _buildNavItem(3, Icons.person_outline, Icons.person, 'Профиль', isDark),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(int index, IconData inactiveIcon, IconData activeIcon, String label, bool isDark) {
    final isActive = _currentIndex == index;
    
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? UrbanTheme.primaryColor.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : inactiveIcon,
              color: isActive ? UrbanTheme.primaryColor : (isDark ? UrbanTheme.darkTextSecondary : Colors.grey),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? UrbanTheme.primaryColor : (isDark ? UrbanTheme.darkTextSecondary : Colors.grey),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreenPlaceholder extends StatelessWidget {
  const ChatScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Чат (в разработке)',
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark 
              ? Colors.white 
              : Colors.black,
        ),
      ),
    );
  }
}
