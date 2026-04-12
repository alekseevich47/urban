import 'package:flutter/material.dart';
import '../models/data_models.dart';
import '../repositories/mock_venue_repository.dart';

/// Провайдер для управления данными заведений.
/// Обеспечивает загрузку, фильтрацию и поиск.
class VenueProvider with ChangeNotifier {
  final VenueRepository _repository;

  /// Все заведения, полученные из репозитория.
  List<EntertainmentVenue> _allVenues = [];

  /// Список заведений после применения фильтров и поиска.
  List<EntertainmentVenue> _filteredVenues = [];

  /// Состояние загрузки данных.
  bool _isLoading = false;

  /// Текущий поисковый запрос.
  String _searchQuery = '';

  /// Выбранная категория для фильтрации.
  VenueCategory? _selectedCategory;

  /// Инициализирует провайдер с заданным репозиторием.
  VenueProvider(this._repository);

  // Геттеры для UI
  List<EntertainmentVenue> get venues => _filteredVenues;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  VenueCategory? get selectedCategory => _selectedCategory;

  /// Загружает заведения из репозитория.
  Future<void> fetchVenues() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allVenues = await _repository.getVenues();
      _applyFilters();
    } catch (e) {
      // Здесь должна быть обработка ошибок согласно правилам §9.2
      debugPrint('Ошибка загрузки заведений: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Устанавливает поисковый запрос и применяет фильтры.
  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  /// Устанавливает выбранную категорию и применяет фильтры.
  void setCategory(VenueCategory? category) {
    if (_selectedCategory == category) {
      _selectedCategory = null; // Сброс при повторном клике
    } else {
      _selectedCategory = category;
    }
    _applyFilters();
    notifyListeners();
  }

  /// Применяет текущие фильтры и поисковый запрос к общему списку.
  void _applyFilters() {
    _filteredVenues = _allVenues.where((venue) {
      // Фильтрация по категории
      final matchesCategory = _selectedCategory == null || venue.category == _selectedCategory;

      // Фильтрация по поисковому запросу
      final matchesSearch = _searchQuery.isEmpty ||
          venue.name.toLowerCase().contains(_searchQuery) ||
          venue.description.toLowerCase().contains(_searchQuery) ||
          venue.keywords.any((kw) => kw.contains(_searchQuery));

      return matchesCategory && matchesSearch;
    }).toList();
  }
}
