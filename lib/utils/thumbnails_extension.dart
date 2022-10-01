import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart';

extension ThumbnailDetailsExt on ThumbnailDetails {
  ImageProvider get image {
    final imageUrl = high?.url ??
        medium?.url ??
        standard?.url ??
        maxres?.url ??
        default_?.url;
    final imageUncasted = imageUrl == null
        ? const AssetImage('assets/white_noise.png')
        : NetworkImage(imageUrl);
    final image = imageUncasted as ImageProvider;
    return image;
  }
}
