enum EntertainmentCategory {
  cinema,
  bowling,
  darts,
  bar,
  rental,
  park,
  beach,
  fishing,
  concert,
  event,
  other,
}

class EntertainmentVenue {
  final String id;
  final String name;
  final EntertainmentCategory category;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final List<String> images;
  final double rating;
  final int reviewsCount;
  final Map<String, dynamic> features; // Специфичные фичи для каждого типа
  final bool isPremium;
  final String? phone;
  final String? socialLink;
  final List<String> tags;

  const EntertainmentVenue({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.images,
    required this.rating,
    required this.reviewsCount,
    required this.features,
    this.isPremium = false,
    this.phone,
    this.socialLink,
    this.tags = const [],
  });

  String get categoryIcon {
    switch (category) {
      case EntertainmentCategory.cinema:
        return '🎬';
      case EntertainmentCategory.bowling:
        return '🎳';
      case EntertainmentCategory.darts:
        return '🎯';
      case EntertainmentCategory.bar:
        return '🍸';
      case EntertainmentCategory.rental:
        return '🚲';
      case EntertainmentCategory.park:
        return '🌳';
      case EntertainmentCategory.beach:
        return '🏖️';
      case EntertainmentCategory.fishing:
        return '🎣';
      case EntertainmentCategory.concert:
        return '🎵';
      case EntertainmentCategory.event:
        return '🎉';
      case EntertainmentCategory.other:
        return '📍';
    }
  }
}

class UserReview {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String venueId;
  final String content;
  final List<String> photos;
  final DateTime createdAt;
  final int likes;

  const UserReview({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.venueId,
    required this.content,
    required this.photos,
    required this.createdAt,
    this.likes = 0,
  });
}

class UserEvent {
  final String id;
  final String creatorId;
  final String title;
  final String description;
  final DateTime dateTime;
  final String location;
  final double latitude;
  final double longitude;
  final int maxParticipants;
  final int currentParticipants;
  final List<String> tags;
  final bool isPrivate;

  const UserEvent({
    required this.id,
    required this.creatorId,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.maxParticipants,
    required this.currentParticipants,
    required this.tags,
    this.isPrivate = false,
  });
}

class UserProfile {
  final String id;
  final String username;
  final String email;
  final String? avatar;
  final List<String> interests;
  final List<String> visitedVenues;
  final List<String> friends;
  final int level;
  final int points;

  const UserProfile({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
    this.interests = const [],
    this.visitedVenues = const [],
    this.friends = const [],
    this.level = 1,
    this.points = 0,
  });
}
