// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/src/data/repositories/auth_repository_impl.dart'
    as _i311;
import '../../features/auth/src/domain/repositories/i_auth_repository.dart'
    as _i310;
import '../../features/settings/src/data/repositories/theme_repository_impl.dart'
    as _i352;
import '../../features/settings/src/domain/repositories/theme_repository.dart'
    as _i759;
import '../../features/settings/src/presentation/bloc/theme_bloc.dart'
    as _i1017;
import '../../features/venues/src/data/repositories/venue_repository_impl.dart'
    as _i170;
import '../../features/venues/src/domain/repositories/i_venue_repository.dart'
    as _i372;
import '../../features/venues/src/domain/use_cases/get_venues_use_case.dart'
    as _i622;
import '../network/pocketbase_service.dart' as _i284;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i284.PocketBaseService>(() => _i284.PocketBaseService());
    gh.lazySingleton<_i759.ThemeRepository>(() => _i352.ThemeRepositoryImpl());
    gh.lazySingleton<_i372.IVenueRepository>(() => _i170.VenueRepositoryImpl());
    gh.lazySingleton<_i310.IAuthRepository>(() => _i311.AuthRepositoryImpl());
    gh.factory<_i622.GetVenuesUseCase>(
        () => _i622.GetVenuesUseCase(gh<_i372.IVenueRepository>()));
    gh.lazySingleton<_i1017.ThemeBloc>(
        () => _i1017.ThemeBloc(gh<_i759.ThemeRepository>()));
    return this;
  }
}
