// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../services/google_auth_service.dart' as _i5;
import '../services/logging_service.dart' as _i3;
import '../services/youtube_mapper.dart' as _i4;
import '../services/youtube_service.dart' as _i6;
import '../view_models/channel_view_model.dart' as _i7;
import '../view_models/playlist_view_model.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.LoggingService>(() => _i3.LoggingService());
  gh.lazySingleton<_i4.YoutubeMapper>(() => _i4.YoutubeMapper());
  gh.lazySingleton<_i5.GoogleAuthService>(
      () => _i5.GoogleAuthService(get<_i3.LoggingService>()));
  gh.singleton<_i6.YoutubeService>(_i6.YoutubeService(
    get<_i5.GoogleAuthService>(),
    get<_i4.YoutubeMapper>(),
  ));
  gh.lazySingleton<_i7.ChannelViewModelFactory>(
      () => _i7.ChannelViewModelFactory(get<_i6.YoutubeService>()));
  gh.lazySingleton<_i8.PlaylistViewModelFactory>(
      () => _i8.PlaylistViewModelFactory(get<_i6.YoutubeService>()));
  return get;
}
