import 'package:latlong2/latlong.dart';

enum VenueCategory {
  concert,
  nightclub,
  bar,
  cinema,
  sport,
  culture,
  other
}

class EntertainmentVenue {
  final String id;
  final String name;
  final String description;
  final VenueCategory category;
  final LatLng location;
  final String imageUrl;
  final double rating;
  final double? priceFrom;

  EntertainmentVenue({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.location,
    required this.imageUrl,
    required this.rating,
    this.priceFrom,
  });
}

// Моковые данные для прототипа
final List<EntertainmentVenue> mockVenues = [
  EntertainmentVenue(
    id: '1',
    name: 'Cyber Arena',
    description: 'Главная киберспортивная арена города. Турниры, VR и мощное железо.',
    category: VenueCategory.sport,
    location: const LatLng(55.751244, 37.618423),
    imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=500',
    rating: 4.9,
    priceFrom: 500,
  ),
  EntertainmentVenue(
    id: '2',
    name: 'Neon Night',
    description: 'Лучшие диджеи и неоновая атмосфера каждую пятницу.',
    category: VenueCategory.nightclub,
    location: const LatLng(55.755826, 37.617300),
    imageUrl: 'https://images.unsplash.com/photo-1551024601-bec78aea704b?q=80&w=500',
    rating: 4.7,
    priceFrom: 1500,
  ),
  EntertainmentVenue(
    id: '3',
    name: 'The Loft Bar',
    description: 'Крафтовое пиво и живая музыка в уютном лофте.',
    category: VenueCategory.bar,
    location: const LatLng(55.749000, 37.625000),
    imageUrl: 'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=500',
    rating: 4.5,
    priceFrom: 800,
  ),
  EntertainmentVenue(
    id: '4',
    name: 'Cinema Future',
    description: 'Кинотеатр с эффектом полного погружения и 4D креслами.',
    category: VenueCategory.cinema,
    location: const LatLng(55.758000, 37.610000),
    imageUrl: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=500',
    rating: 4.8,
    priceFrom: 400,
  ),
];
