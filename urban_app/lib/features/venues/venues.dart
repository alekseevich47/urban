/// Public API модуля "Заведения" (Venues).
/// 
/// Экспортирует основные сущности, BLoC и экраны для использования в других модулях.
library venues;

// Сущности домена
export 'src/domain/entities/venue.dart';

// Репозитории (интерфейсы)
export 'src/domain/repositories/i_venue_repository.dart';

// Презентация: BLoC
export 'src/presentation/bloc/venue_bloc.dart';
export 'src/presentation/bloc/venue_event.dart';
export 'src/presentation/bloc/venue_state.dart';

// Презентация: Экраны
export 'src/presentation/pages/feed_screen.dart';
