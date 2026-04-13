import 'package:equatable/equatable.dart';
import '../../domain/entities/venue.dart';

/// Базовый класс для состояний BLoC заведений.
abstract class VenueState extends Equatable {
  const VenueState();

  @override
  List<Object?> get props => [];
}

/// Начальное состояние.
class VenueInitial extends VenueState {
  const VenueInitial();
}

/// Состояние загрузки данных.
class VenueLoading extends VenueState {
  const VenueLoading();
}

/// Состояние успешно загруженных данных.
/// Содержит списки заведений (все и отфильтрованные) и параметры фильтрации.
class VenueLoaded extends VenueState {
  final List<EntertainmentVenue> allVenues;
  final List<EntertainmentVenue> filteredVenues;
  final String searchQuery;
  final VenueCategory? selectedCategory;

  const VenueLoaded({
    required this.allVenues,
    required this.filteredVenues,
    this.searchQuery = '',
    this.selectedCategory,
  });

  /// Создает копию состояния с измененными полями.
  VenueLoaded copyWith({
    List<EntertainmentVenue>? allVenues,
    List<EntertainmentVenue>? filteredVenues,
    String? searchQuery,
    VenueCategory? selectedCategory,
    bool clearCategory = false,
  }) {
    return VenueLoaded(
      allVenues: allVenues ?? this.allVenues,
      filteredVenues: filteredVenues ?? this.filteredVenues,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: clearCategory ? null : (selectedCategory ?? this.selectedCategory),
    );
  }

  @override
  List<Object?> get props => [allVenues, filteredVenues, searchQuery, selectedCategory];
}

/// Состояние ошибки.
class VenueError extends VenueState {
  final String message;
  const VenueError(this.message);

  @override
  List<Object?> get props => [message];
}
