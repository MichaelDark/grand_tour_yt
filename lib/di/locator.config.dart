// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../providers/youtube_channel_view_model.dart' as _i6;
import '../services/google_auth_service.dart' as _i4;
import '../services/logging_service.dart' as _i3;
import '../services/youtube_service.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i4.GoogleAuthService>(
      () => _i4.GoogleAuthService(get<_i3.LoggingService>()));
  gh.singleton<_i5.YoutubeService>(
      _i5.YoutubeService(get<_i4.GoogleAuthService>()));
  gh.lazySingleton<_i6.YoutubeChannelViewModel>(
      () => _i6.YoutubeChannelViewModel(get<_i5.YoutubeService>()));
  gh.lazySingleton<_i6.YoutubePlaylistViewModelFactory>(
      () => _i6.YoutubePlaylistViewModelFactory(get<_i5.YoutubeService>()));
  return get;
}