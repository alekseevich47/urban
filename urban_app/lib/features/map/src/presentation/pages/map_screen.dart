import 'dart:async';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import '../../domain/entities/urban_marker.dart';
import '../../data/repositories/map_repository_impl.dart';

/// Основной экран карты (Vector MapLibre)
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapLibreMapController? _mapController;
  final MapRepositoryImpl _repository = MapRepositoryImpl();
  
  List<UrbanMarker> _markers = [];
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
  }

  /// Загрузка маркеров с сервера с учетом видимой области карты
  Future<void> _loadMarkers() async {
    // ВРЕМЕННО ОТКЛЮЧАЕМ логику маркеров для настройки отображения карты
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapLibreMap(
            styleString: 'https://urban42.online/map/styles/bright/style.json',
            initialCameraPosition: const CameraPosition(
              target: LatLng(55.0084, 82.9357), // Новосибирск
              zoom: 12.0,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onStyleLoadedCallback: () {
              _loadMarkers();
            },
            rotateGesturesEnabled: false,
            tiltGesturesEnabled: false,
            myLocationEnabled: true,
            trackCameraPosition: true,
            onMapLongClick: (point, latLng) => _handleMapLongPress(latLng),
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

  /// Обработка долгого нажатия на карту для создания нового маркера
  void _handleMapLongPress(LatLng point) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить новое место?'),
        content: Text('Координаты: ${point.latitude.toStringAsFixed(4)}, ${point.longitude.toStringAsFixed(4)}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showAddMarkerForm(point);
            },
            child: const Text('Да'),
          ),
        ],
      ),
    );
  }

  void _showAddMarkerForm(LatLng point) {
    // В будущем здесь будет переход на полноценный экран формы
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Открываем форму для точки: $point')),
    );
  }
}
