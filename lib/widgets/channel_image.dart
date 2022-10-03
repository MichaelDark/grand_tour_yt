import 'package:flutter/material.dart';

import '../models/youtube/youtube_thumbnail.dart';
import '../utils/youtube_thumbnail_ext.dart';

class ChannelImage extends StatelessWidget {
  final YoutubeThumbnail thumbnail;

  const ChannelImage({super.key, required this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image(
          image: thumbnail.image,
          height: 128,
          width: 128,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
