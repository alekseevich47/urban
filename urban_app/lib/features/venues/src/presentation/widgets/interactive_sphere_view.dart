import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:urban_app/features/venues/src/domain/entities/venue.dart';
import 'package:urban_app/core/ui/urban_theme.dart';

class InteractiveSphereView extends StatefulWidget {
  final List<EntertainmentVenue> venues;
  const InteractiveSphereView({super.key, required this.venues});

  @override
  State<InteractiveSphereView> createState() => _InteractiveSphereViewState();
}

class _InteractiveSphereViewState extends State<InteractiveSphereView> {
  double _angleX = 0;
  double _angleY = 0;
  EntertainmentVenue? _selectedVenue;

  @override
  Widget build(BuildContext context) {
    if (widget.venues.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final double radius = constraints.maxWidth * 0.35;
        final double centerX = constraints.maxWidth / 2;
        final double centerY = constraints.maxHeight / 2;

        return Stack(
          children: [
            // Фон со свечением
            Center(
              child: Container(
                width: radius * 2, height: radius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: UrbanTheme.primaryColor.withOpacity(0.05), blurRadius: 100, spreadRadius: 50),
                  ],
                ),
              ),
            ),

            // Сама сфера (обработчик жестов)
            GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _angleY += details.delta.dx * 0.005;
                  _angleX -= details.delta.dy * 0.005;
                });
              },
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: _buildSphereItems(centerX, centerY, radius),
                ),
              ),
            ),

            // Полноэкранный просмотр поста
            if (_selectedVenue != null) _buildDetailedView(),
          ],
        );
      }
    );
  }

  List<Widget> _buildSphereItems(double centerX, double centerY, double radius) {
    List<Widget> items = [];
    final int count = widget.venues.length;

    for (int i = 0; i < count; i++) {
      // Алгоритм Фибоначчи для распределения точек
      double phi = math.acos(-1.0 + (2.0 * i) / count);
      double theta = math.sqrt(count * math.pi) * phi;

      // Применяем текущее вращение
      double x = radius * math.cos(theta + _angleY) * math.sin(phi + _angleX);
      double y = radius * math.sin(theta + _angleY) * math.sin(phi + _angleX);
      double z = radius * math.cos(phi + _angleX);

      // Проекция
      double scale = (z + radius) / (2 * radius); // от 0.0 до 1.0
      double opacity = math.max(0.1, scale);

      // Размер элемента на основе удаленности (z)
      double itemSize = 60 * (0.5 + scale);

      // Рисуем только те, что не слишком глубоко сзади (для производительности)
      if (z > -radius * 0.8) {
        items.add(
          Positioned(
            left: centerX + x - (itemSize / 2),
            top: centerY + y - (itemSize / 2),
            child: GestureDetector(
              onTap: () => setState(() => _selectedVenue = widget.venues[i]),
              child: Opacity(
                opacity: opacity,
                child: _buildMiniature(widget.venues[i], itemSize),
              ),
            ),
          ),
        );
      }
    }

    // Сортировка по Z-индексу (упрощенно через порядок в списке для Flutter Stack)
    // Но для Stack проще всего просто не рисовать задние или использовать прозрачность
    return items;
  }

  Widget _buildMiniature(EntertainmentVenue venue, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.2),
        border: Border.all(color: UrbanTheme.primaryColor.withOpacity(0.5), width: 1),
        image: DecorationImage(
          image: NetworkImage(venue.imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(color: UrbanTheme.primaryColor.withOpacity(0.2), blurRadius: 4),
        ],
      ),
    );
  }

  Widget _buildDetailedView() {
    final venue = _selectedVenue!;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.8 + (0.2 * value),
            child: child,
          ),
        );
      },
      child: Scaffold(
        backgroundColor: UrbanTheme.backgroundColor.withOpacity(0.95),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(venue.imageUrl, width: double.infinity, height: 350, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(venue.category.label.toUpperCase(),
                          style: UrbanTheme.bodySmall.copyWith(color: UrbanTheme.primaryColor, letterSpacing: 2)),
                        const SizedBox(height: 8),
                        Text(venue.name, style: UrbanTheme.headingLarge),
                        const SizedBox(height: 16),
                        Text(venue.description, style: UrbanTheme.bodyMedium),
                        const SizedBox(height: 30),
                        _buildInfoRow(Icons.star, 'Рейтинг: ${venue.rating}'),
                        _buildInfoRow(Icons.payments_outlined, 'Цена: ${venue.tags.price}'),
                        _buildInfoRow(Icons.people_outline, 'Компания: ${venue.tags.company}'),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: UrbanTheme.primaryColor,
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {},
                          child: const Text('ПЕРЕЙТИ К КАРТЕ', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 40, right: 20,
              child: IconButton(
                icon: const CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.close, color: Colors.white),
                ),
                onPressed: () => setState(() => _selectedVenue = null),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: UrbanTheme.textMuted),
          const SizedBox(width: 12),
          Text(text, style: UrbanTheme.bodyMedium),
        ],
      ),
    );
  }
}
