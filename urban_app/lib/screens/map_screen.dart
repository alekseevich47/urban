import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/urban_theme.dart';
import '../models/data_models.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isListView = false;
  bool _showFilters = false;
  Set<EntertainmentCategory> _selectedCategories = {};

  final List<EntertainmentVenue> _mockVenues = [
    EntertainmentVenue(
      id: '1',
      name: 'Киноплекс "Неон"',
      category: EntertainmentCategory.cinema,
      description: 'Современный кинотеатр с IMAX залами',
      address: 'ул. Ленина, 45',
      latitude: 55.751244,
      longitude: 37.618423,
      images: ['https://picsum.photos/400/300?random=1'],
      rating: 4.8,
      reviewsCount: 342,
      features: {'halls': 8, 'imax': true},
      isPremium: true,
      tags: ['кино', 'imax', 'премьеры'],
    ),
    EntertainmentVenue(
      id: '2',
      name: 'ВелоДрайв',
      category: EntertainmentCategory.rental,
      description: 'Прокат велосипедов и электросамокатов',
      address: 'Парк Горького, вход 3',
      latitude: 55.729838,
      longitude: 37.601265,
      images: ['https://picsum.photos/400/300?random=2'],
      rating: 4.5,
      reviewsCount: 128,
      features: {'bikes': 50, 'scooters': 30},
      tags: ['велосипеды', 'прокат', 'парк'],
    ),
    EntertainmentVenue(
      id: '3',
      name: 'Боулинг "СтраЙк"',
      category: EntertainmentCategory.bowling,
      description: '12 дорожек, бар, зона для детей',
      address: 'ТЦ "Плаза", 3 этаж',
      latitude: 55.760234,
      longitude: 37.635678,
      images: ['https://picsum.photos/400/300?random=3'],
      rating: 4.6,
      reviewsCount: 215,
      features: {'lanes': 12, 'bar': true},
      tags: ['боулинг', 'семья', 'бар'],
    ),
    EntertainmentVenue(
      id: '4',
      name: 'Рок-бар "Гараж"',
      category: EntertainmentCategory.bar,
      description: 'Живая музыка каждый вечер',
      address: 'ул. Тверская, 12',
      latitude: 55.755826,
      longitude: 37.617300,
      images: ['https://picsum.photos/400/300?random=4'],
      rating: 4.7,
      reviewsCount: 456,
      features: {'liveMusic': true, 'capacity': 150},
      tags: ['бар', 'музыка', 'концерты'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UrbanTheme.backgroundColor,
      body: Stack(
        children: [
          // Карта или список
          _isListView ? _buildListView() : _buildMapView(),

          // Верхняя панель поиска и фильтров
          _buildTopBar(),

          // Плавающая кнопка переключения вида
          _buildViewToggle(),

          // Кнопка создания ивента
          _buildCreateEventButton(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildMapView() {
    // В реальной реализации здесь будет flutter_map или Google Maps
    return Container(
      color: UrbanTheme.surfaceColor,
      child: Stack(
        children: [
          // Имитация карты с сеткой
          CustomPaint(
            size: Size.infinite,
            painter: GridPainter(),
          ),
          // Маркеры заведений
          ..._mockVenues.map((venue) => _buildMapMarker(venue)),
        ],
      ),
    );
  }

  Widget _buildMapMarker(EntertainmentVenue venue) {
    return Positioned(
      left: MediaQuery.of(context).size.width * (venue.latitude - 55.72) * 100,
      top: MediaQuery.of(context).size.height * (venue.longitude - 37.58) * 50,
      child: GestureDetector(
        onTap: () => _showVenueDetails(venue),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: venue.isPremium 
                ? UrbanTheme.accentColor 
                : UrbanTheme.primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: (venue.isPremium 
                    ? UrbanTheme.accentColor 
                    : UrbanTheme.primaryColor).withOpacity(0.5),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Text(
            venue.categoryIcon,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 140, bottom: 80),
      itemCount: _mockVenues.length,
      itemBuilder: (context, index) {
        final venue = _mockVenues[index];
        return _buildVenueCard(venue);
      },
    );
  }

  Widget _buildVenueCard(EntertainmentVenue venue) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: UrbanTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Изображение
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  venue.images.first,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: UrbanTheme.surfaceColor,
                    child: Icon(Icons.image, size: 64, color: UrbanTheme.textMuted),
                  ),
                ),
              ),
              if (venue.isPremium)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: UrbanTheme.neonGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'PREMIUM',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Информация
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      venue.categoryIcon,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        venue.name,
                        style: UrbanTheme.headingSmall,
                      ),
                    ),
                    Icon(Icons.star, size: 18, color: UrbanTheme.warningColor),
                    const SizedBox(width: 4),
                    Text(
                      '${venue.rating}',
                      style: UrbanTheme.bodyMedium.copyWith(
                        color: UrbanTheme.warningColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  venue.address,
                  style: UrbanTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: venue.tags
                      .map((tag) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: UrbanTheme.surfaceColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tag,
                              style: UrbanTheme.bodySmall.copyWith(
                                color: UrbanTheme.secondaryColor,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showVenueDetails(venue),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UrbanTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Подробнее'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 16,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              UrbanTheme.backgroundColor.withOpacity(0.95),
              UrbanTheme.backgroundColor.withOpacity(0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Поиск
            TextField(
              decoration: UrbanTheme.searchInputDecoration,
              onChanged: (value) {
                // Логика поиска
              },
            ),
            const SizedBox(height: 12),
            // Фильтры
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Все', EntertainmentCategory.other),
                  _buildFilterChip('🎬 Кино', EntertainmentCategory.cinema),
                  _buildFilterChip('🎳 Боулинг', EntertainmentCategory.bowling),
                  _buildFilterChip('🍸 Бары', EntertainmentCategory.bar),
                  _buildFilterChip('🚲 Прокат', EntertainmentCategory.rental),
                  _buildFilterChip('🎉 Ивенты', EntertainmentCategory.event),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, EntertainmentCategory category) {
    final isSelected = _selectedCategories.contains(category) || 
                       (_selectedCategories.isEmpty && category == EntertainmentCategory.other);
    
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            if (category == EntertainmentCategory.other) {
              _selectedCategories.clear();
            } else {
              if (selected) {
                _selectedCategories.add(category);
              } else {
                _selectedCategories.remove(category);
              }
            }
          });
        },
        backgroundColor: UrbanTheme.surfaceColor,
        selectedColor: UrbanTheme.primaryColor.withOpacity(0.3),
        checkmarkColor: UrbanTheme.primaryColor,
        labelStyle: UrbanTheme.bodySmall.copyWith(
          color: isSelected ? UrbanTheme.primaryColor : UrbanTheme.textSecondary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? UrbanTheme.primaryColor : Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _buildViewToggle() {
    return Positioned(
      right: 16,
      bottom: 100,
      child: FloatingActionButton(
        heroTag: 'viewToggle',
        mini: true,
        onPressed: () {
          setState(() {
            _isListView = !_isListView;
          });
        },
        backgroundColor: UrbanTheme.secondaryColor,
        child: Icon(_isListView ? Icons.map : Icons.list),
      ),
    );
  }

  Widget _buildCreateEventButton() {
    return Positioned(
      right: 16,
      bottom: 160,
      child: FloatingActionButton(
        heroTag: 'createEvent',
        mini: true,
        onPressed: () {
          // Навигация на создание ивента
        },
        backgroundColor: UrbanTheme.accentColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.map_outlined, Icons.map, true, 'Карта'),
            _buildNavItem(Icons.explore_outlined, Icons.explore, false, 'Лента'),
            _buildNavItem(Icons.chat_outlined, Icons.chat, false, 'Чат'),
            _buildNavItem(Icons.person_outline, Icons.person, false, 'Профиль'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData inactiveIcon, IconData activeIcon, bool isActive, String label) {
    return GestureDetector(
      onTap: () {
        // Навигация
      },
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
            ),
          ),
        ],
      ),
    );
  }

  void _showVenueDetails(EntertainmentVenue venue) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: UrbanTheme.cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: UrbanTheme.textMuted,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(venue.name, style: UrbanTheme.headingMedium),
                    const SizedBox(height: 8),
                    Text(venue.description, style: UrbanTheme.bodyMedium),
                    const SizedBox(height: 16),
                    // Здесь будут детали: фото, отзывы, бронирование
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Художник для рисования сетки карты
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = UrbanTheme.textMuted.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const gridSize = 50.0;

    for (var i = 0.0; i < size.width; i += gridSize) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (var i = 0.0; i < size.height; i += gridSize) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
