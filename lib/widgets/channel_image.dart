import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:grandtouryt/utils/thumbnails_extension.dart';

class ChannelImage extends StatelessWidget {
  final ThumbnailDetails thumbnailDetails;

  const ChannelImage({super.key, required this.thumbnailDetails});

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
          image: thumbnailDetails.image,
          height: 128,
          width: 128,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
