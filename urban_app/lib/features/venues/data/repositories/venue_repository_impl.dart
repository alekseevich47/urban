import '../../../../models/data_models.dart';
import '../../domain/repositories/i_venue_repository.dart';

/// Реализация репозитория заведений.
/// В данной версии использует фиксированные данные (Mock).
/// В будущем здесь будет обращение к API (PocketBase/Supabase).
class VenueRepositoryImpl implements IVenueRepository {
  @override
  Future<List<EntertainmentVenue>> getVenues() async {
    // Имитация задержки сети согласно §7.1 (L2 кэш еще не внедрен)
    await Future.delayed(const Duration(milliseconds: 800));

    return const [
      EntertainmentVenue(
        id: '1',
        name: 'Клуб "Мутабор"',
        description: 'Техно-клуб с уникальной атмосферой и световыми шоу.',
        category: VenueCategory.nightlife,
        subCategory: 'Техно',
        location: UrbanLocation(55.719601, 37.674984),
        imageUrl: 'https://images.unsplash.com/photo-1571266028243-e4bb3340028a?auto=format&fit=crop&q=80&w=400',
        rating: 4.8,
        priceFrom: 1500,
        keywords: ['техно', 'клубы', 'ночь', '18+', 'дорого'],
        tags: VenueTags(price: 'дорого', time: ['ночь'], age: '18+', isActive: true),
      ),
      EntertainmentVenue(
        id: '2',
        name: 'VR-парк "Teleport"',
        description: 'Огромный парк виртуальной реальности с командными играми.',
        category: VenueCategory.gaming,
        subCategory: 'VR',
        location: UrbanLocation(55.760123, 37.601245),
        imageUrl: 'https://images.unsplash.com/photo-1593508512255-86ab42a8e620?auto=format&fit=crop&q=80&w=400',
        rating: 4.9,
        priceFrom: 800,
        keywords: ['игры', 'VR', 'гейминг', 'дети', 'компании'],
        tags: VenueTags(price: 'средне', time: ['день', 'вечер'], age: '6+', isActive: true),
      ),
      EntertainmentVenue(
        id: '3',
        name: 'Театр "Практика"',
        description: 'Современный театр с необычными постановками.',
        category: VenueCategory.culture,
        subCategory: 'Драма',
        location: UrbanLocation(55.766124, 37.595123),
        imageUrl: 'https://images.unsplash.com/photo-1503095396549-807039045349?auto=format&fit=crop&q=80&w=400',
        rating: 4.7,
        priceFrom: 1200,
        keywords: ['культура', 'театры', 'спектакли', 'пары'],
        tags: VenueTags(price: 'средне', time: ['вечер'], age: '12+', isActive: false),
      ),
      EntertainmentVenue(
        id: '4',
        name: 'Ресторан "Satori"',
        description: 'Азиатская кухня в авторском исполнении.',
        category: VenueCategory.food,
        subCategory: 'Японская',
        location: UrbanLocation(55.753124, 37.621123),
        imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&q=80&w=400',
        rating: 4.6,
        priceFrom: 2000,
        keywords: ['еда', 'рестораны', 'азия', 'пары', 'дорого'],
        tags: VenueTags(price: 'дорого', time: ['день', 'вечер'], age: '0+', isActive: false),
      ),
      EntertainmentVenue(
        id: '5',
        name: 'Парк Горького',
        description: 'Главный парк города: каток, прокат, фестивали.',
        category: VenueCategory.nature,
        subCategory: 'Парки',
        location: UrbanLocation(55.729124, 37.601123),
        imageUrl: 'https://images.unsplash.com/photo-1546702287-6302568600d8?auto=format&fit=crop&q=80&w=400',
        rating: 4.9,
        priceFrom: 0,
        keywords: ['природа', 'парки', 'гулять', 'семья', 'бесплатно'],
        tags: VenueTags(price: 'бесплатно', time: ['утро', 'день', 'вечер'], age: '0+', isActive: true),
      ),
    ];
  }
}
