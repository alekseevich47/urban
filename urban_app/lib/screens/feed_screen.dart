import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../theme/urban_theme.dart';
import '../models/data_models.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with SingleTickerProviderStateMixin {
  bool _isSphereView = false;
  late AnimationController _sphereAnimationController;
  
  final List<UserReview> _mockReviews = [
    UserReview(
      id: '1',
      userId: 'u1',
      userName: 'Алексей М.',
      userAvatar: 'https://picsum.photos/100/100?random=10',
      venueId: '1',
      content: 'Отличный кинотеатр! Зал IMAX просто потрясающий, звук и картинка на высоте. Бронировал места через приложение - всё удобно.',
      photos: ['https://picsum.photos/400/300?random=20', 'https://picsum.photos/400/300?random=21'],
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      likes: 24,
    ),
    UserReview(
      id: '2',
      userId: 'u2',
      userName: 'Мария К.',
      userAvatar: 'https://picsum.photos/100/100?random=11',
      venueId: '2',
      content: 'Брали велосипеды на прокат в парке. Всё чистое, исправное. Цены адекватные. Рекомендую!',
      photos: ['https://picsum.photos/400/300?random=22'],
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      likes: 18,
    ),
    UserReview(
      id: '3',
      userId: 'u3',
      userName: 'Дмитрий С.',
      userAvatar: 'https://picsum.photos/100/100?random=12',
      venueId: '4',
      content: 'Атмосферное место! Живая музыка каждый вечер, коктейли отличные. Обязательно вернусь ещё.',
      photos: [],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      likes: 42,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _sphereAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    if (_isSphereView) {
      _sphereAnimationController.repeat();
    }
  }

  @override
  void dispose() {
    _sphereAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UrbanTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // Верхняя панель с переключателем вида
          SliverAppBar(
            floating: true,
            backgroundColor: UrbanTheme.backgroundColor,
            title: Text(
              _isSphereView ? 'Сфера развлечений' : 'Лента',
              style: UrbanTheme.headingMedium,
            ),
            actions: [
              IconButton(
                icon: Icon(_isSphereView ? Icons.view_list : Icons.public),
                onPressed: () {
                  setState(() {
                    _isSphereView = !_isSphereView;
                    if (_isSphereView) {
                      _sphereAnimationController.repeat();
                    } else {
                      _sphereAnimationController.stop();
                    }
                  });
                },
                tooltip: _isSphereView ? 'Список' : 'Сфера',
              ),
              const SizedBox(width: 8),
            ],
          ),

          // Рекламный баннер (ненавязчивый)
          SliverToBoxAdapter(
            child: FadeInDown(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: UrbanTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Скидка 20% на первый визит',
                            style: UrbanTheme.headingSmall.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'В Киноплекс "Неон" до конца недели',
                            style: UrbanTheme.bodySmall.copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.local_offer, color: Colors.white, size: 32),
                  ],
                ),
              ),
            ),
          ),

          // Фильтры контента
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildContentFilter('Все', isActive: true),
                    _buildContentFilter('Друзья'),
                    _buildContentFilter('Рекомендации'),
                    _buildContentFilter('Ивенты'),
                    _buildContentFilter('Рядом'),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),

          // Лента постов
          if (!_isSphereView)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final review = _mockReviews[index % _mockReviews.length];
                  return FadeInUp(
                    delay: Duration(milliseconds: index * 100),
                    child: _buildReviewCard(review),
                  );
                },
                childCount: _mockReviews.length * 3, // Для демонстрации скролла
              ),
            )
          else
            // Сферический вид (инновация)
            SliverFillRemaining(
              child: _buildSphereView(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Создание нового поста
        },
        backgroundColor: UrbanTheme.accentColor,
        icon: const Icon(Icons.camera_alt),
        label: const Text('Пост'),
      ),
    );
  }

  Widget _buildContentFilter(String label, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isActive,
        onSelected: (selected) {
          // Логика фильтрации
        },
        backgroundColor: UrbanTheme.surfaceColor,
        selectedColor: UrbanTheme.secondaryColor.withOpacity(0.3),
        checkmarkColor: UrbanTheme.secondaryColor,
        labelStyle: UrbanTheme.bodySmall.copyWith(
          color: isActive ? UrbanTheme.secondaryColor : UrbanTheme.textSecondary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isActive ? UrbanTheme.secondaryColor : Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard(UserReview review) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: UrbanTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок с пользователем
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(review.userAvatar),
                  radius: 20,
                  onBackgroundImageError: (_, __) {},
                  child: review.userAvatar.isEmpty 
                      ? const Icon(Icons.person) 
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style: UrbanTheme.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _formatTimeAgo(review.createdAt),
                        style: UrbanTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                  color: UrbanTheme.textMuted,
                ),
              ],
            ),
          ),

          // Текст отзыва
          if (review.content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                review.content,
                style: UrbanTheme.bodyMedium,
              ),
            ),

          // Фотографии
          if (review.photos.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: review.photos.length == 1
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        review.photos.first,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 200,
                          color: UrbanTheme.surfaceColor,
                          child: const Icon(Icons.image, size: 64),
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: review.photos.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            review.photos[index],
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: UrbanTheme.surfaceColor,
                              child: const Icon(Icons.image),
                            ),
                          ),
                        );
                      },
                    ),
            ),

          // Действия (лайки, комментарии)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {},
                      color: UrbanTheme.textMuted,
                      iconSize: 20,
                    ),
                    Text(
                      '${review.likes}',
                      style: UrbanTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.comment_outlined),
                      onPressed: () {},
                      color: UrbanTheme.textMuted,
                      iconSize: 20,
                    ),
                    Text(
                      'Комментировать',
                      style: UrbanTheme.bodySmall,
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () {},
                  color: UrbanTheme.textMuted,
                  iconSize: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSphereView() {
    // Инновационный вид ленты в виде сферы
    // В реальной реализации здесь будет 3D сфера с контентом
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Анимированная сфера (упрощенная визуализация)
          AnimatedBuilder(
            animation: _sphereAnimationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _sphereAnimationController.value * 2 * 3.14159,
                child: CustomPaint(
                  size: const Size(300, 300),
                  painter: SpherePainter(_mockReviews),
                ),
              );
            },
          ),
          // Центральный текст
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.public, size: 64, color: UrbanTheme.primaryColor),
              const SizedBox(height: 16),
              Text(
                'Сфера развлечений',
                style: UrbanTheme.headingMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Исследуйте контент в новом формате',
                style: UrbanTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inHours < 1) {
      return '${difference.inMinutes} мин назад';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} ч назад';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} дн назад';
    } else {
      return '${dateTime.day}.${dateTime.month}';
    }
  }
}

// Художник для рисования сферы с контентом
class SpherePainter extends CustomPainter {
  final List<UserReview> reviews;

  SpherePainter(this.reviews);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Рисуем сферу
    final spherePaint = Paint()
      ..color = UrbanTheme.primaryColor.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius, spherePaint);

    // Рисуем точки контента на сфере
    for (int i = 0; i < reviews.length; i++) {
      final angle = (i / reviews.length) * 2 * 3.14159;
      final x = center.dx + (radius - 20) * Math.cos(angle);
      final y = center.dy + (radius - 20) * Math.sin(angle);

      final dotPaint = Paint()
        ..color = i == 0 ? UrbanTheme.accentColor : UrbanTheme.secondaryColor
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), 8, dotPaint);

      // Добавляем свечение
      final glowPaint = Paint()
        ..color = (i == 0 ? UrbanTheme.accentColor : UrbanTheme.secondaryColor).withOpacity(0.3)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

      canvas.drawCircle(Offset(x, y), 12, glowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant SpherePainter oldDelegate) => true;
}

// Математические функции для сферы
class Math {
  static double cos(double radians) => rcos(radians);
  static double sin(double radians) => rsin(radians);
  
  static double rcos(double radians) {
    return cosValue(radians);
  }
  
  static double rsin(double radians) {
    return sinValue(radians);
  }
  
  static double cosValue(double radians) {
    return radians; // Упрощение для прототипа
  }
  
  static double sinValue(double radians) {
    return radians; // Упрощение для прототипа
  }
}
