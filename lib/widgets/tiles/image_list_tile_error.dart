import 'package:flutter/material.dart';

import '../resources/error_view.dart';

class ImageListTileError extends StatelessWidget {
  final dynamic error;
  final VoidCallback? retry;

  const ImageListTileError({
    Key? key,
    this.error,
    this.retry,
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).errorColor,
                ),
              ),
              child: ErrorView(
                error,
                retry: retry,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
