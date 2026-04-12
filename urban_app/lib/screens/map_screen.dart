import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:provider/provider.dart';
import '../theme/urban_theme.dart';
import '../models/data_models.dart';
import '../providers/venue_provider.dart';

/// Экран с картой заведений Urban.
/// Использует Яндекс.Карты для отображения локаций и взаимодействия с пользователем.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  /// Контроллер для управления картой Яндекс.
  late YandexMapController _mapController;

  /// Выбранное заведение для отображения карточки.
  EntertainmentVenue? _selectedVenue;

  /// Список объектов (маркеров) на карте.
  final List<MapObject> _mapObjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<VenueProvider>(
        builder: (context, provider, child) {
          // Обновляем маркеры при изменении данных в провайдере
          _updateMapObjects(provider.venues);

          return Stack(
            children: [
              // Основной виджет Яндекс.Карт
              YandexMap(
                onMapCreated: (controller) async {
                  _mapController = controller;
                  // Установка начальной позиции (Москва)
                  await _mapController.moveCamera(
                    animation: const MapAnimation(type: MapAnimationType.smooth, duration: 2.0),
                    CameraUpdate.newCameraPosition(
                      const CameraPosition(
                        target: Point(latitude: 55.751244, longitude: 37.618423),
                        zoom: 13,
                      ),
                    ),
                  );
                },
                mapObjects: _mapObjects,
                onMapTap: (point) {
                  setState(() {
                    _selectedVenue = null;
                  });
                },
              ),

              // Поле поиска и фильтры сверху
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildSearchField(provider),
                      const SizedBox(height: 12),
                      _buildQuickFilters(provider),
                    ],
                  ),
                ),
              ),

              // Индикатор загрузки
              if (provider.isLoading)
                const Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircularProgressIndicator(color: UrbanTheme.primaryColor),
                  ),
                ),

              // Карточка выбранного заведения снизу
              if (_selectedVenue != null)
                Positioned(
                  bottom: 20,
                  left: 16,
                  right: 16,
                  child: _buildVenueCard(_selectedVenue!),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _mapController.moveCamera(
            animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1.0),
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                target: Point(latitude: 55.751244, longitude: 37.618423),
                zoom: 13,
              ),
            ),
          );
        },
        backgroundColor: UrbanTheme.surfaceColor,
        child: const Icon(Icons.my_location, color: UrbanTheme.primaryColor),
      ),
    );
  }

  /// Обновляет список маркеров на карте на основе списка заведений.
  void _updateMapObjects(List<EntertainmentVenue> venues) {
    _mapObjects.clear();
    for (final venue in venues) {
      _mapObjects.add(
        PlacemarkMapObject(
          mapId: MapObjectId('venue_${venue.id}'),
          point: Point(
            latitude: venue.location.latitude,
            longitude: venue.location.longitude,
          ),
          opacity: 1,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/icons/map_marker.png'),
              scale: 0.8,
            ),
          ),
          onTap: (object, point) {
            setState(() {
              _selectedVenue = venue;
            });
          },
        ),
      );
    }
  }

  /// Строит поле текстового поиска.
  Widget _buildSearchField(VenueProvider provider) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) => provider.setSearchQuery(value),
        style: UrbanTheme.bodyMedium.copyWith(color: Colors.white),
        decoration: UrbanTheme.searchInputDecoration.copyWith(
          hintText: 'Поиск (клуб, затусить, 18+)...',
          suffixIcon: provider.venues.isEmpty && !provider.isLoading
              ? const Icon(Icons.search_off, color: UrbanTheme.accentColor)
              : const Icon(Icons.search, color: UrbanTheme.primaryColor),
        ),
      ),
    );
  }

  /// Строит горизонтальный список быстрых фильтров по категориям.
  Widget _buildQuickFilters(VenueProvider provider) {
    return Row(
      children: [
        // Кнопка вызова всех категорий
        GestureDetector(
          onTap: () => _showAllCategories(context, provider),
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: UrbanTheme.surfaceColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: UrbanTheme.primaryColor.withOpacity(0.5)),
            ),
            child: const Icon(Icons.grid_view_rounded, color: UrbanTheme.primaryColor, size: 20),
          ),
        ),
        const SizedBox(width: 8),
        // Горизонтальный список
        Expanded(
          child: SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: VenueCategory.values.length + 1,
              itemBuilder: (context, index) {
                final isAll = index == 0;
                final category = isAll ? null : VenueCategory.values[index - 1];
                final isSelected = provider.selectedCategory == category;

                final label = isAll ? 'Все' : category!.label;
                final icon = isAll ? Icons.all_inclusive : category!.icon;

                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () => provider.setCategory(category),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? UrbanTheme.primaryColor : UrbanTheme.surfaceColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? UrbanTheme.secondaryColor : UrbanTheme.textMuted.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            icon,
                            size: 18,
                            color: isSelected ? Colors.white : UrbanTheme.textMuted,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            label,
                            style: UrbanTheme.bodyMedium.copyWith(
                              color: isSelected ? Colors.white : UrbanTheme.textMuted,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Отображает модальное окно со всеми категориями заведений.
  void _showAllCategories(BuildContext context, VenueProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: UrbanTheme.backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(top: BorderSide(color: UrbanTheme.primaryColor, width: 2)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Категории Urban', style: UrbanTheme.headingMedium),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: UrbanTheme.textMuted),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: VenueCategory.values.length,
                itemBuilder: (context, index) {
                  final category = VenueCategory.values[index];
                  final isSelected = provider.selectedCategory == category;
                  return GestureDetector(
                    onTap: () {
                      provider.setCategory(category);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? UrbanTheme.primaryColor.withOpacity(0.2) : UrbanTheme.surfaceColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? UrbanTheme.primaryColor : Colors.transparent,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(category.icon, color: isSelected ? UrbanTheme.primaryColor : Colors.white, size: 32),
                          const SizedBox(height: 8),
                          Text(
                            category.label,
                            textAlign: TextAlign.center,
                            style: UrbanTheme.bodySmall.copyWith(
                              color: isSelected ? UrbanTheme.primaryColor : Colors.white,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Строит информационную карточку заведения.
  Widget _buildVenueCard(EntertainmentVenue venue) {
    return Container(
      height: 120,
      decoration: UrbanTheme.cardDecoration.copyWith(
        color: UrbanTheme.surfaceColor,
        border: Border.all(color: UrbanTheme.primaryColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Image.network(
              venue.imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          venue.name,
                          style: UrbanTheme.headingSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: UrbanTheme.successColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: UrbanTheme.successColor, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              venue.rating.toString(),
                              style: UrbanTheme.bodySmall.copyWith(color: UrbanTheme.successColor, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    venue.description,
                    style: UrbanTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'от ${venue.priceFrom?.toInt() ?? 0} ₽',
                        style: UrbanTheme.bodyMedium.copyWith(color: UrbanTheme.secondaryColor, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Подробнее →',
                          style: UrbanTheme.bodySmall.copyWith(color: UrbanTheme.primaryColor),
                        ),
                      ),
                    ],
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
