import 'package:flutter/material.dart';
import 'package:urban_app/core/ui/urban_theme.dart';
import 'package:urban_app/features/settings/src/presentation/pages/settings_screen.dart';

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
      backgroundColor: UrbanTheme.getBackgroundColor(context),
      body: SafeArea(
        top: true,
        child: CustomScrollView(
          slivers: [
            // App Bar с профилем
            SliverAppBar(
              expandedHeight: 250,
              floating: false,
              pinned: true,
              backgroundColor: UrbanTheme.getBackgroundColor(context),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings_outlined, color: UrbanTheme.getTextPrimary(context)),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SettingsScreen()),
                    );
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Градиентный фон
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            UrbanTheme.getBackgroundColor(context),
                            UrbanTheme.getSurfaceColor(context),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    // Аватар и информация
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Аватар
                          Stack(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: UrbanTheme.primaryGradient,
                                  boxShadow: [
                                    BoxShadow(
                                      color: UrbanTheme.primaryColor.withValues(alpha: 0.5),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    user.avatar!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: UrbanTheme.secondaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: UrbanTheme.getBackgroundColor(context), width: 2),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Имя пользователя
                          Text(
                            '@${user.username}',
                            style: UrbanTheme.headingMedium(context),
                          ),
                          const SizedBox(height: 4),
                          // Уровень
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: UrbanTheme.primaryColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: UrbanTheme.primaryColor.withValues(alpha: 0.5)),
                            ),
                            child: Text(
                              'Lvl ${user.level} • ${user.points} XP',
                              style: UrbanTheme.bodySmall(context).copyWith(color: UrbanTheme.primaryColor),
                            ),
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
                    _buildStatItem(context, '12', 'Посещений'),
                    _buildStatItem(context, '28', 'Фото'),
                    _buildStatItem(context, '156', 'Друзей'),
                    _buildStatItem(context, '42', 'Отзыва'),
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
                    Text('Интересы', style: UrbanTheme.headingSmall(context)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: user.interests
                          .map((interest) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: UrbanTheme.getSurfaceColor(context),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: UrbanTheme.primaryColor.withValues(alpha: 0.3)),
                                ),
                                child: Text(
                                  interest,
                                  style: UrbanTheme.bodySmall(context).copyWith(color: UrbanTheme.primaryColor),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Стена
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Стена', style: UrbanTheme.headingSmall(context)),
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
                          color: UrbanTheme.getSurfaceColor(context),
                          child: const Icon(Icons.image, size: 32),
                        ),
                      ),
                    );
                  },
                  childCount: 6,
                ),
              ),
            ),

            // Меню (без пункта "Настройки")
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    _buildMenuItem(context, Icons.person_outline, 'Редактировать профиль'),
                    _buildMenuItem(context, Icons.people_outline, 'Друзья'),
                    _buildMenuItem(context, Icons.message_outlined, 'Сообщения'),
                    _buildMenuItem(context, Icons.event_outlined, 'Мои ивенты'),
                    _buildMenuItem(context, Icons.bookmark_outline, 'Избранное'),
                    _buildMenuItem(context, Icons.help_outline, 'Поддержка'),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.logout),
                        label: const Text('Выйти'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UrbanTheme.errorColor.withValues(alpha: 0.1),
                          foregroundColor: UrbanTheme.errorColor,
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
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: UrbanTheme.headingMedium(context).copyWith(
            color: UrbanTheme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: UrbanTheme.bodySmall(context),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: UrbanTheme.getTextSecondary(context)),
      title: Text(label, style: UrbanTheme.bodyLarge(context)),
      trailing: Icon(Icons.chevron_right, color: UrbanTheme.getTextSecondary(context)),
      onTap: () {},
      contentPadding: EdgeInsets.zero,
    );
  }
}
