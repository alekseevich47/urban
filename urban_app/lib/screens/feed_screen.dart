import 'package:flutter/material.dart';
import '../theme/urban_theme.dart';
import '../models/data_models.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UrbanTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: UrbanTheme.backgroundColor,
        elevation: 0,
        title: Text('Лента событий', style: UrbanTheme.headingMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: UrbanTheme.primaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockVenues.length,
        itemBuilder: (context, index) {
          final venue = mockVenues[index];
          return _buildFeedItem(venue);
        },
      ),
    );
  }

  Widget _buildFeedItem(EntertainmentVenue venue) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: UrbanTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Шапка карточки (Автор/Место)
          ListTile(
            leading: CircleAvatar(
              backgroundColor: UrbanTheme.primaryColor.withOpacity(0.2),
              child: const Icon(Icons.person, color: UrbanTheme.primaryColor),
            ),
            title: Text(venue.name, style: UrbanTheme.headingSmall),
            subtitle: Text('2 часа назад • Москва', style: UrbanTheme.bodySmall),
            trailing: const Icon(Icons.more_vert, color: UrbanTheme.textMuted),
          ),

          // Изображение
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(venue.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: UrbanTheme.warningColor, size: 16),
                          const SizedBox(width: 4),
                          Text(venue.rating.toString(), style: UrbanTheme.bodySmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Текст и описание
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  venue.description,
                  style: UrbanTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStat(Icons.favorite_border, '1.2k'),
                    const SizedBox(width: 16),
                    _buildStat(Icons.chat_bubble_outline, '45'),
                    const SizedBox(width: 16),
                    _buildStat(Icons.share_outlined, '12'),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: UrbanTheme.neonButtonDecoration.copyWith(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Забронировать',
                        style: UrbanTheme.bodySmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String count) {
    return Row(
      children: [
        Icon(icon, size: 20, color: UrbanTheme.textMuted),
        const SizedBox(width: 4),
        Text(count, style: UrbanTheme.bodySmall),
      ],
    );
  }
}
