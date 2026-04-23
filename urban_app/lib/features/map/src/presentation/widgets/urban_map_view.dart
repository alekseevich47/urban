import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:urban_app/core/ui/urban_theme.dart';
import '../../domain/entities/map_item.dart';

/// Универсальный виджет карты Urban (переведен на OSM).
class UrbanMapView extends StatefulWidget {
  final List<MapItem> items;
  final void Function(MapItem item)? onItemTap;
  final VoidCallback? onMapTap;
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
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: const LatLng(55.7558, 37.6173),
            initialZoom: 13.0,
            onTap: (_, __) => widget.onMapTap?.call(),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://urban42.online/map/styles/bright/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.urbanapp.urban_app',
            ),
            MarkerLayer(
              markers: widget.items.map((item) {
                return Marker(
                  point: LatLng(item.latitude, item.longitude),
                  width: 40,
                  height: 40,
                  child: GestureDetector(
                    onTap: () => widget.onItemTap?.call(item),
                    child: Image.asset(
                      item.iconAsset ?? 'assets/icons/map_marker.png',
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.location_on, color: Colors.red, size: 40),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        if (widget.children != null) ...widget.children!,
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: _goToUserLocation,
            backgroundColor: UrbanTheme.getSurfaceColor(context),
            child: const Icon(Icons.my_location, color: UrbanTheme.primaryColor),
          ),
        ),
      ],
    );
  }

  Future<void> _goToUserLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      _mapController.move(
        LatLng(position.latitude, position.longitude),
        15.0,
      );
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }
}
