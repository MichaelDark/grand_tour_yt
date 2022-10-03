import 'package:flutter/material.dart';

import '../models/youtube/youtube_thumbnail.dart';

extension YoutubeThumbnailExt on YoutubeThumbnail {
  ImageProvider get image {
    final imageUrl = this.imageUrl;
    final imageUncasted = imageUrl == null
        ? const AssetImage('assets/white_noise.png')
        : NetworkImage(imageUrl);
    final image = imageUncasted as ImageProvider;
    return image;
  }
}
