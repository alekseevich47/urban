import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/ui/urban_theme.dart';
import '../../domain/entities/map_item.dart';

/// Универсальный виджет карты Urban.
/// Инкапсулирует логику работы с Яндекс.Картами и геолокацией.
class UrbanMapView extends StatefulWidget {
  /// Список элементов для отображения на карте.
  final List<MapItem> items;

  /// Обработчик нажатия на объект.
  final void Function(MapItem item)? onItemTap;

  /// Обработчик нажатия на саму карту.
  final VoidCallback? onMapTap;

  /// Позволяет передать дополнительные слои (например, поиск) поверх карты.
  final List<Widget>? children;

  const UrbanMapView({
    super.key,
    required this.items,
    this.onItemTap,
    this.onMapTap,
    this.children,
  });

  @override
  State<UrbanMapView> createState() => _UrbanMapViewState();
}

class _UrbanMapViewState extends State<UrbanMapView> {
  late YandexMapController _mapController;
  final List<MapObject> _mapObjects = [];

  @override
  void didUpdateWidget(UrbanMapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _updateMapObjects();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        YandexMap(
          onMapCreated: (controller) async {
            _mapController = controller;
            await _mapController.toggleUserLayer(visible: true);
            await _goToUserLocation();
            _updateMapObjects();
          },
          mapObjects: _mapObjects,
          onMapTap: (point) => widget.onMapTap?.call(),
        ),
        if (widget.children != null) ...widget.children!,
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: _goToUserLocation,
            backgroundColor: UrbanTheme.surfaceColor,
            child: const Icon(Icons.my_location, color: UrbanTheme.primaryColor),
          ),
        ),
      ],
    );
  }

  /// Обновляет маркеры на карте.
  void _updateMapObjects() {
    setState(() {
      _mapObjects.clear();
      for (final item in widget.items) {
        _mapObjects.add(
          PlacemarkMapObject(
            mapId: MapObjectId('point_${item.id}'),
            point: Point(
              latitude: item.latitude,
              longitude: item.longitude,
            ),
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(item.iconAsset ?? 'assets/icons/map_marker.png'),
                scale: 0.8,
              ),
            ),
            onTap: (object, point) => widget.onItemTap?.call(item),
          ),
        );
      }
    });
  }

  /// Перемещает камеру к текущему местоположению пользователя.
  Future<void> _goToUserLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final request = await Geolocator.requestPermission();
        if (request == LocationPermission.denied) return;
      }

      final position = await Geolocator.getCurrentPosition();
      await _mapController.moveCamera(
        animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1.5),
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(
              latitude: position.latitude,
              longitude: position.longitude,
            ),
            zoom: 15,
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }
}
