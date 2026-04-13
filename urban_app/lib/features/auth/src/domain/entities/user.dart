import 'package:equatable/equatable.dart';

/// Сущность пользователя Urban.
class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String? avatar;
  final List<String> interests;
  final List<String> visitedVenues;
  final int level;
  final int points;

  const User({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
    this.interests = const [],
    this.visitedVenues = const [],
    this.level = 1,
    this.points = 0,
  });

  @override
  List<Object?> get props => [id, username, email, avatar, interests, visitedVenues, level, points];
}
