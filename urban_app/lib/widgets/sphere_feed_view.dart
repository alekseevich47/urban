import 'dart:math';
import 'package:flutter/material.dart';
import '../models/data_models.dart';
import '../theme/urban_theme.dart';

class SphereFeedView extends StatefulWidget {
  final List<EntertainmentVenue> venues;
  const SphereFeedView({super.key, required this.venues});

  @override
  State<SphereFeedView> createState() => _SphereFeedViewState();
}

class _SphereFeedViewState extends State<SphereFeedView> {
  late FixedExtentScrollController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Фоновое свечение за активной карточкой
        Center(
          child: Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: UrbanTheme.primaryColor.withOpacity(0.15),
                  blurRadius: 100,
                  spreadRadius: 50,
                ),
              ],
            ),
          ),
        ),

        ListWheelScrollView.useDelegate(
          controller: _controller,
          itemExtent: 450, // Высота "окна" для одной карточки
          perspective: 0.003,
          diameterRatio: 2.0,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: widget.venues.length,
            builder: (context, index) {
              final venue = widget.venues[index];
              final isSelected = _selectedIndex == index;

              return AnimatedScale(
                scale: isSelected ? 1.0 : 0.8,
                duration: const Duration(milliseconds: 300),
                child: AnimatedOpacity(
                  opacity: isSelected ? 1.0 : 0.5,
                  duration: const Duration(milliseconds: 300),
                  child: _buildSphereCard(venue),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSphereCard(EntertainmentVenue venue) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: UrbanTheme.surfaceColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: UrbanTheme.primaryColor.withOpacity(0.5),
          width: 2,
        ),
        image: DecorationImage(
          image: NetworkImage(venue.imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: UrbanTheme.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Контент карточки
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: UrbanTheme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    venue.category.label.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  venue.name,
                  style: UrbanTheme.headingLarge.copyWith(
                    fontSize: 28,
                    shadows: [
                      const Shadow(color: Colors.black, blurRadius: 10, offset: Offset(2, 2)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  venue.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: UrbanTheme.bodyMedium.copyWith(color: Colors.white.withOpacity(0.9)),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.star, color: UrbanTheme.warningColor, size: 20),
                    const SizedBox(width: 4),
                    Text(venue.rating.toString(), style: UrbanTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
