// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../services/google_auth_service.dart' as _i7;
import '../services/logging_service.dart' as _i3;
import '../services/search_query_service.dart' as _i4;
import '../services/settings_service.dart' as _i5;
import '../services/youtube_mapper.dart' as _i6;
import '../services/youtube_service.dart' as _i8;
import '../view_models/channel_view_model.dart' as _i9;
import '../view_models/playlist_view_model.dart' as _i10;
import '../view_models/video_search_view_model.dart' as _i11;
import '../view_models/video_view_model.dart'
    as _i12; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i3.LoggingService>(() => _i3.LoggingService());
  await gh.singletonAsync<_i4.SearchQueryService>(
    () => _i4.SearchQueryService.create(),
    preResolve: true,
  );
  gh.singleton<_i5.SettingsService>(_i5.SettingsService());
  gh.lazySingleton<_i6.YoutubeMapper>(() => _i6.YoutubeMapper());
  gh.lazySingleton<_i7.GoogleAuthService>(
      () => _i7.GoogleAuthService(get<_i3.LoggingService>()));
  gh.singleton<_i8.YoutubeService>(_i8.YoutubeService(
    get<_i7.GoogleAuthService>(),
    get<_i6.YoutubeMapper>(),
  ));
  gh.lazySingleton<_i9.ChannelViewModelFactory>(
      () => _i9.ChannelViewModelFactory(get<_i8.YoutubeService>()));
  gh.lazySingleton<_i10.PlaylistViewModelFactory>(
      () => _i10.PlaylistViewModelFactory(get<_i8.YoutubeService>()));
  gh.lazySingleton<_i11.VideoSearchViewModelFactory>(
      () => _i11.VideoSearchViewModelFactory(get<_i8.YoutubeService>()));
  gh.lazySingleton<_i12.VideoViewModelFactory>(
      () => _i12.VideoViewModelFactory(get<_i8.YoutubeService>()));
  return get;
}
