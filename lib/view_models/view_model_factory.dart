import 'view_model_models.dart';

abstract class ViewModelFactory {
  List<String> get channelIds;

  ChannelViewModel channel(String channelId);
  PlaylistViewModel playlist(String playlistId);
  VideoSearchViewModel videoSearch(String channelId, String query);
  VideoViewModel video(String videoId);
}
