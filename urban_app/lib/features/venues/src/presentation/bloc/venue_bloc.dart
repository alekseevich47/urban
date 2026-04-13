import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_app/core/utils/logger.dart';
import 'package:urban_app/features/venues/src/domain/entities/venue.dart';
import 'package:urban_app/features/venues/src/domain/use_cases/get_venues_use_case.dart';
import 'venue_event.dart';
import 'venue_state.dart';

/// BLoC для управления списком и фильтрацией заведений.
class VenueBloc extends Bloc<VenueEvent, VenueState> {
  final GetVenuesUseCase _getVenuesUseCase;

  VenueBloc({required GetVenuesUseCase getVenuesUseCase})
      : _getVenuesUseCase = getVenuesUseCase,
        super(const VenueInitial()) {
    on<FetchVenuesEvent>(_onFetchVenues);
    on<SearchQueryChangedEvent>(_onSearchQueryChanged);
    on<CategorySelectedEvent>(_onCategorySelected);
  }

  /// Обработка события начальной загрузки заведений.
  Future<void> _onFetchVenues(
    FetchVenuesEvent event,
    Emitter<VenueState> emit,
  ) async {
    emit(const VenueLoading());
    try {
      final venues = await _getVenuesUseCase();
      emit(VenueLoaded(
        allVenues: venues,
        filteredVenues: venues,
      ));
      UrbanLogger.i('Loaded ${venues.length} venues', tag: 'VenueBloc');
    } catch (e, stackTrace) {
      UrbanLogger.e('Failed to fetch venues', error: e, stackTrace: stackTrace, tag: 'VenueBloc');
      emit(const VenueError('Не удалось загрузить список заведений'));
    }
  }

  /// Обработка изменения поискового запроса.
  void _onSearchQueryChanged(
    SearchQueryChangedEvent event,
    Emitter<VenueState> emit,
  ) {
    final currentState = state;
    if (currentState is VenueLoaded) {
      final filtered = _applyFilters(
        currentState.allVenues,
        event.query,
        currentState.selectedCategory,
      );
      emit(currentState.copyWith(
        searchQuery: event.query,
        filteredVenues: filtered,
      ));
    }
  }

  /// Обработка выбора категории.
  void _onCategorySelected(
    CategorySelectedEvent event,
    Emitter<VenueState> emit,
  ) {
    final currentState = state;
    if (currentState is VenueLoaded) {
      final filtered = _applyFilters(
        currentState.allVenues,
        currentState.searchQuery,
        event.category,
      );
      emit(currentState.copyWith(
        selectedCategory: event.category,
        filteredVenues: filtered,
        clearCategory: event.category == null,
      ));
    }
  }

  /// Применяет поиск и категорию к списку заведений.
  List<EntertainmentVenue> _applyFilters(
    List<EntertainmentVenue> venues,
    String query,
    VenueCategory? category,
  ) {
    return venues.where((venue) {
      final matchesQuery = query.isEmpty ||
          venue.name.toLowerCase().contains(query.toLowerCase()) ||
          venue.keywords.any((k) => k.toLowerCase().contains(query.toLowerCase()));
      
      final matchesCategory = category == null || venue.category == category;
      
      return matchesQuery && matchesCategory;
    }).toList();
  }
}
