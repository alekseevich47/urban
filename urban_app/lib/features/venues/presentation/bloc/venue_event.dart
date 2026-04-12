import 'package:equatable/equatable.dart';
import '../../../../models/data_models.dart';

/// Базовый класс для событий BLoC заведений.
abstract class VenueEvent extends Equatable {
  const VenueEvent();

  @override
  List<Object?> get props => [];
}

/// Событие загрузки списка заведений.
class FetchVenuesEvent extends VenueEvent {
  const FetchVenuesEvent();
}

/// Событие изменения поискового запроса.
class SearchQueryChangedEvent extends VenueEvent {
  final String query;
  const SearchQueryChangedEvent(this.query);

  @override
  List<Object?> get props => [query];
}

/// Событие фильтрации по категории.
class CategorySelectedEvent extends VenueEvent {
  final VenueCategory? category;
  const CategorySelectedEvent(this.category);

  @override
  List<Object?> get props => [category];
}
