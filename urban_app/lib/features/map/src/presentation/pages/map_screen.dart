import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/entities/urban_marker.dart';
import '../../data/repositories/map_repository_impl.dart';

/// Основной экран карты (OpenStreetMap)
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final MapRepositoryImpl _repository = MapRepositoryImpl();
  
  List<UrbanMarker> _markers = [];
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    // Начальная загрузка маркеров
    _loadMarkers();
  }

  /// Загрузка маркеров с сервера с учетом видимой области карты
  Future<void> _loadMarkers() async {
    final bounds = _mapController.camera.visibleBounds;
    
    try {
      final markers = await _repository.getMarkersInBounds(
        minLat: bounds.south,
        maxLat: bounds.north,
        minLng: bounds.west,
        maxLng: bounds.east,
      );
      
      if (mounted) {
        setState(() {
          _markers = markers;
        });
      }
    } catch (e) {
      // Логирование ошибок через UrbanLogger (надо импортировать)
    }
  }

  /// Метод для обработки перемещения карты с задержкой (Debounce)
  void _onPositionChanged(MapCamera camera, bool hasGesture) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _loadMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(55.7558, 37.6173), // Москва по умолчанию
              initialZoom: 13.0,
              onPositionChanged: _onPositionChanged,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.urbanapp.urban_app',
              ),
              MarkerLayer(
                markers: _markers.map((marker) => Marker(
                  point: LatLng(marker.latitude, marker.longitude),
                  width: 40,
                  height: 40,
                  child: GestureDetector(
                    onTap: () => _showMarkerDetails(marker),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
          
          // Верхняя панель управления (Фильтры)
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: _buildFilterBar(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewMarker,
        child: const Icon(Icons.add_location_alt),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black26)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.filter_list),
          const SizedBox(width: 8),
          const Text('Развлечения'),
          const SizedBox(width: 8),
          const Text('События'),
        ],
      ),
    );
  }

  void _showMarkerDetails(UrbanMarker marker) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(marker.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(marker.snippet ?? 'Нет описания'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {}, 
              child: const Text('Перейти на страницу заведения')
            ),
          ],
        ),
      ),
    );
  }

  void _createNewMarker() {
    // Здесь будет логика открытия экрана/формы создания маркера
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Здесь будет форма добавления нового места')),
    );
  }
}
