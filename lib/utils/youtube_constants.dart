abstract class YoutubeConstants {
  static const grandTourChannelId = 'UCZ1Sc5xjWpUnp_o_lUTkvgQ';
  static const driveTribeChannelId = 'UChiwLDIBJrV5SxqdixMHmQA';
  static const whatsNextChannelId = 'UCLw8Z2SQXD_v07gei77mQiA';
  static const richardHammondChannelId = 'UCheylHaby1OjlvHZgqBlKZw';
  static const smarterEveryDayChannelId = 'UC6107grRI4m0o2-emgoDnAA';
  static const iDidAThingChannelId = 'UCJLZe_NoiG0hT7QCX_9vmqw';

  static const parts = _Parts();
  static const channels = [
    grandTourChannelId,
    driveTribeChannelId,
    whatsNextChannelId,
    richardHammondChannelId,
    smarterEveryDayChannelId,
    iDidAThingChannelId,
  ];

  YoutubeConstants._();
}

class _Parts {
  const _Parts();

  List<String> get channels => [
        'snippet',
        'contentDetails',
        'statistics',

        // unused
        // 'status',
      ];

  List<String> get playlists => [
        'id',
        'snippet',

        // unused
        // 'contentDetails',
        // 'localizations',
        // 'player',
        // 'status',
      ];

  List<String> get playlist => const [
        'contentDetails',
        'id',
        'snippet',
        // unused
        // 'status',
      ];

  List<String> get video => const [
        'contentDetails',
        'id',
        'snippet',
        'statistics',

        // unused
        // 'liveStreamingDetails',
        // 'localizations',
        // 'player',
        // 'recordingDetails',
        // 'status',
        // 'topicDetails',

        // available only for file owner
        // 'fileDetails',
        // 'processingDetails',
        // 'suggestions',
      ];

  List<String> get search => const [
        'id',
        'snippet',
      ];
}
