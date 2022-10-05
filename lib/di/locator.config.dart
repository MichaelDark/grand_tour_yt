// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i5;

import '../services/auth_service.dart' as _i10;
import '../services/impl/google_api_youtube_mapper.dart' as _i3;
import '../services/impl/google_api_youtube_service.dart' as _i13;
import '../services/impl/google_auth_service.dart' as _i11;
import '../services/impl/hive_search_query_repository.dart' as _i7;
import '../services/impl/listenable_settings_service.dart' as _i9;
import '../services/search_query_repository.dart' as _i6;
import '../services/settings_service.dart' as _i8;
import '../services/youtube_service.dart' as _i12;
import '../view_models/impl/cached_view_model_factory.dart' as _i15;
import '../view_models/view_model_factory.dart' as _i14;
import 'modules/google_module.dart' as _i16;
import 'modules/logger_module.dart'
    as _i17; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final googleModule = _$GoogleModule();
  final loggerModule = _$LoggerModule();
  gh.lazySingleton<_i3.GoogleApiYoutubeMapper>(
      () => _i3.GoogleApiYoutubeMapper());
  gh.lazySingleton<_i4.GoogleSignIn>(() => googleModule.googleSignIn());
  gh.lazySingleton<_i5.Logger>(() => loggerModule.logger());
  await gh.singletonAsync<_i6.SearchQueryRepository>(
    () => _i7.HiveSearchQueryRepository.create(get<_i5.Logger>()),
    preResolve: true,
  );
  gh.singleton<_i8.SettingsService>(
      _i9.ListenableSettingsService(get<_i5.Logger>()));
  gh.lazySingleton<_i10.AuthService>(() => _i11.GoogleAuthService(
        get<_i5.Logger>(),
        get<_i4.GoogleSignIn>(),
      ));
  gh.singleton<_i12.YoutubeService>(_i13.GoogleApiYoutubeService(
    get<_i5.Logger>(),
    get<_i10.AuthService>(),
    get<_i3.GoogleApiYoutubeMapper>(),
  ));
  gh.lazySingleton<_i14.ViewModelFactory>(
      () => _i15.CachedViewModelFactory(get<_i12.YoutubeService>()));
  return get;
}

class _$GoogleModule extends _i16.GoogleModule {}

class _$LoggerModule extends _i17.LoggerModule {}
