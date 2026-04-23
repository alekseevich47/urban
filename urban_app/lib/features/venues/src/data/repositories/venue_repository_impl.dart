import 'package:injectable/injectable.dart';
import '../../domain/entities/venue.dart';
import '../../domain/repositories/i_venue_repository.dart';

/// Реализация репозитория заведений.
/// В данной версии использует фиксированные данные (Mock).
/// В будущем здесь будет обращение к API (PocketBase/Supabase).
@LazySingleton(as: IVenueRepository)
class VenueRepositoryImpl implements IVenueRepository {
  @override
  Future<List<EntertainmentVenue>> getVenues() async {
    // Имитация задержки сети согласно §7.1 (L2 кэш еще не внедрен)
    await Future.delayed(const Duration(milliseconds: 800));

    final List<EntertainmentVenue> venues = [];
    final List<String> baseNames = [
      'Мутабор', 'Teleport', 'Практика', 'Satori', 'Парк Горького',
      'CyberArena', 'NeoTokyo', 'Art Loft', 'Sky Bar', 'Green Garden',
      'Velocity', 'Pixel Museum', 'Zen Garden', 'Neon Bowling', 'Aura Spa'
    ];

    final List<String> imageUrls = [
      'https://images.unsplash.com/photo-1571266028243-e4bb3340028a?auto=format&fit=crop&q=80&w=400',
      'https://images.unsplash.com/photo-1593508512255-86ab42a8e620?auto=format&fit=crop&q=80&w=400',
      'https://images.unsplash.com/photo-1503095396549-807039045349?auto=format&fit=crop&q=80&w=400',
      'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&q=80&w=400',
      'https://images.unsplash.com/photo-1546702287-6302568600d8?auto=format&fit=crop&q=80&w=400',
      'https://images.unsplash.com/photo-1566417713940-fe7c737a9ef2?auto=format&fit=crop&q=80&w=400',
      'https://images.unsplash.com/photo-1514525253344-f814d0743b17?auto=format&fit=crop&q=80&w=400',
      'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?auto=format&fit=crop&q=80&w=400',
      'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?auto=format&fit=crop&q=80&w=400',
      'https://images.unsplash.com/photo-1520209759809-a9bcb6cb3241?auto=format&fit=crop&q=80&w=400',
    ];

    for (int i = 1; i <= 100; i++) {
      final category = VenueCategory.values[i % VenueCategory.values.length];
      final isVideo = i % 3 == 0;
      final name = isVideo ? 'Video: ${baseNames[i % baseNames.length]}' : baseNames[i % baseNames.length];
      
      venues.add(
        EntertainmentVenue(
          id: '$i',
          name: '$name #$i',
          description: 'Это детальное описание для заведения #$i. Здесь может быть много текста о том, как провести время в этой локации.',
          category: category,
          subCategory: 'Подкатегория ${i % 5}',
          location: UrbanLocation(55.75 + (i * 0.001), 37.61 + (i * 0.002)),
          imageUrl: imageUrls[i % imageUrls.length],
          rating: (4.0 + (i % 10) / 10.0).clamp(0.0, 5.0),
          priceFrom: (i % 7) * 400.0 + 500.0,
          keywords: ['тест', category.label.toLowerCase(), 'город'],
          tags: VenueTags(
            price: i % 3 == 0 ? 'дорого' : 'средне',
            time: ['день', 'вечер'],
            age: i % 2 == 0 ? '18+' : '0+',
            isActive: true,
          ),
          authorName: i % 5 == 0 ? 'Urban Official' : 'User_$i',
          authorAvatar: 'https://i.pravatar.cc/100?u=$i',
          likesCount: (i * 123) % 1000,
          viewsCount: (i * 456) % 5000,
        ),
      );
    }

    return venues;
  }

}
