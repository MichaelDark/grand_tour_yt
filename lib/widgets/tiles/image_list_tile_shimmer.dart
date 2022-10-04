import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'image_list_tile.dart';

class ImageListTileShimmer extends StatelessWidget {
  const ImageListTileShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.primary,
                    highlightColor: Theme.of(context).colorScheme.secondary,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: ImageListTile.getBackgroundColor(context),
                    child: Text(
                      'Loading...',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
