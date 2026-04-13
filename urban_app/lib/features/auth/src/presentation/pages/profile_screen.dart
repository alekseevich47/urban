import 'package:flutter/material.dart';
import '../../../../core/ui/urban_theme.dart';

/// Модель профиля пользователя (временная заглушка)
class UserProfile {
  final String id;
  final String username;
  final String email;
  final String? avatar;
  final List<String> interests;
  final List<String> visitedVenues;
  final int level;
  final int points;

  const UserProfile({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
    required this.interests,
    required this.visitedVenues,
    required this.level,
    required this.points,
  });
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Мок пользователя
    final user = UserProfile(
      id: '1',
      username: 'alex_urban',
      email: 'alex@example.com',
      avatar: 'https://picsum.photos/200/200?random=50',
      interests: ['Кино', 'Велосипеды', 'Концерты'],
      visitedVenues: ['1', '2', '4'],
      level: 5,
      points: 1250,
    );

    return Scaffold(
      backgroundColor: UrbanTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar с профилем
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            backgroundColor: UrbanTheme.backgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Градиентный фон
                  Container(
                    decoration: BoxDecoration(
                      gradient: UrbanTheme.darkGradient,
                    ),
                  ),
                  // Аватар и информация
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Уровень и очки
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: UrbanTheme.neonGradient,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star, size: 16, color: Colors.white),
                                const SizedBox(width: 4),
                                Text(
                                  'Lvl ${user.level}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Аватар
                        Stack(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: UrbanTheme.primaryGradient,
                                boxShadow: [
                                  BoxShadow(
                                    color: UrbanTheme.primaryColor.withOpacity(0.5),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  user.avatar!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: UrbanTheme.secondaryColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: UrbanTheme.backgroundColor, width: 3),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Имя пользователя
                        Text(
                          '@${user.username}',
                          style: UrbanTheme.headingMedium,
                        ),
                        const SizedBox(height: 8),
                        // Очки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star_outline, size: 18, color: UrbanTheme.warningColor),
                            const SizedBox(width: 4),
                            Text(
                              '${user.points} очков',
                              style: UrbanTheme.bodyMedium.copyWith(color: UrbanTheme.warningColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Статистика
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('12', 'Посещений'),
                  _buildStatItem('28', 'Фото'),
                  _buildStatItem('156', 'Друзей'),
                  _buildStatItem('42', 'Отзыва'),
                ],
              ),
            ),
          ),

          // Интересы
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Интересы', style: UrbanTheme.headingSmall),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: user.interests
                        .map((interest) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: UrbanTheme.surfaceColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: UrbanTheme.primaryColor.withOpacity(0.3)),
                              ),
                              child: Text(
                                interest,
                                style: UrbanTheme.bodySmall.copyWith(color: UrbanTheme.primaryColor),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Стена (лента фото пользователя)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Стена', style: UrbanTheme.headingSmall),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Все'),
                  ),
                ],
              ),
            ),
          ),

          // Сетка фотографий
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://picsum.photos/200/200?random=${index + 100}',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: UrbanTheme.surfaceColor,
                        child: const Icon(Icons.image, size: 32),
                      ),
                    ),
                  );
                },
                childCount: 9,
              ),
            ),
          ),

          // Меню настроек
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  _buildMenuItem(Icons.person_outline, 'Редактировать профиль'),
                  _buildMenuItem(Icons.people_outline, 'Друзья'),
                  _buildMenuItem(Icons.message_outlined, 'Сообщения'),
                  _buildMenuItem(Icons.event_outlined, 'Мои ивенты'),
                  _buildMenuItem(Icons.bookmark_outline, 'Избранное'),
                  _buildMenuItem(Icons.settings_outlined, 'Настройки'),
                  _buildMenuItem(Icons.help_outline, 'Поддержка'),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout),
                      label: const Text('Выйти'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UrbanTheme.accentColor.withOpacity(0.2),
                        foregroundColor: UrbanTheme.accentColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: UrbanTheme.headingMedium.copyWith(
            color: UrbanTheme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: UrbanTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: UrbanTheme.textSecondary),
      title: Text(label, style: UrbanTheme.bodyLarge),
      trailing: const Icon(Icons.chevron_right, color: UrbanTheme.textMuted),
      onTap: () {},
      contentPadding: EdgeInsets.zero,
    );
  }
}
