import 'package:flutter/material.dart';

class ImageListTile extends StatelessWidget {
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary.withOpacity(0.75);
  }

  static Color getForegroundColor(BuildContext context) {
    return Theme.of(context).colorScheme.onPrimary;
  }

  final String title;
  final ImageProvider image;
  final List<Widget> stackChildren;
  final VoidCallback onTap;

  const ImageListTile({
    Key? key,
    required this.title,
    required this.image,
    this.stackChildren = const [],
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).shadowColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image(
                      image: image,
                      fit: BoxFit.cover,
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
                        title,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                  ),
                  ...stackChildren,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
