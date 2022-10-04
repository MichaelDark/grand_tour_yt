import 'package:flutter/material.dart';

import '../models/youtube/youtube_thumbnail.dart';
import 'assets.gen.dart';

extension YoutubeThumbnailExt on YoutubeThumbnail {
  ImageProvider get image {
    final imageUrl = this.imageUrl;
    final imageUncasted = imageUrl == null
        ? AssetImage(Assets.whiteNoise.path)
        : NetworkImage(imageUrl);
    final image = imageUncasted as ImageProvider;
    return image;
  }
}
