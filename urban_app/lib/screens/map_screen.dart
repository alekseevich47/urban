import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../theme/urban_theme.dart';
import '../models/data_models.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  EntertainmentVenue? _selectedVenue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(55.751244, 37.618423), // Москва
              initialZoom: 13.0,
              onTap: (_, __) {
                setState(() {
                  _selectedVenue = null;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.urban.app',
                retinaMode: true,
              ),
              MarkerLayer(
                markers: mockVenues.map((venue) {
                  return Marker(
                    point: venue.location,
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedVenue = venue;
                        });
                        _mapController.move(venue.location, 15.0);
                      },
                      child: _buildMarker(venue),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // Поле поиска сверху
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
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
                      style: UrbanTheme.bodyMedium.copyWith(color: Colors.white),
                      decoration: UrbanTheme.searchInputDecoration.copyWith(
                        hintText: 'Поиск мест в Москве...',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildQuickFilters(),
                ],
              ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mapController.move(const LatLng(55.751244, 37.618423), 13.0);
        },
        backgroundColor: UrbanTheme.surfaceColor,
        child: const Icon(Icons.my_location, color: UrbanTheme.primaryColor),
      ),
    );
  }

  Widget _buildMarker(EntertainmentVenue venue) {
    Color markerColor;
    switch (venue.category) {
      case VenueCategory.nightclub: markerColor = UrbanTheme.accentColor; break;
      case VenueCategory.bar: markerColor = UrbanTheme.warningColor; break;
      case VenueCategory.sport: markerColor = UrbanTheme.secondaryColor; break;
      case VenueCategory.cinema: markerColor = UrbanTheme.successColor; break;
      default: markerColor = UrbanTheme.primaryColor;
    }

    return Container(
      decoration: BoxDecoration(
        color: markerColor.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(color: markerColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: markerColor.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          _getCategoryIcon(venue.category),
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }

  IconData _getCategoryIcon(VenueCategory category) {
    switch (category) {
      case VenueCategory.nightclub: return Icons.nightlife;
      case VenueCategory.bar: return Icons.local_bar;
      case VenueCategory.sport: return Icons.sports_esports;
      case VenueCategory.cinema: return Icons.movie;
      default: return Icons.place;
    }
  }

  Widget _buildQuickFilters() {
    final filters = [
      {'label': 'Все', 'icon': Icons.all_inclusive},
      {'label': 'Клубы', 'icon': Icons.nightlife},
      {'label': 'Бары', 'icon': Icons.local_bar},
      {'label': 'Спорт', 'icon': Icons.sports_esports},
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == 0;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isSelected ? UrbanTheme.primaryColor : UrbanTheme.surfaceColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? UrbanTheme.primaryColor : UrbanTheme.textMuted.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  filters[index]['icon'] as IconData,
                  size: 16,
                  color: isSelected ? Colors.white : UrbanTheme.textMuted,
                ),
                const SizedBox(width: 8),
                Text(
                  filters[index]['label'] as String,
                  style: UrbanTheme.bodySmall.copyWith(
                    color: isSelected ? Colors.white : UrbanTheme.textMuted,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

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
