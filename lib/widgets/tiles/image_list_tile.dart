import 'package:flutter/material.dart';

class ImageListTile extends StatelessWidget {
  static Color get backgroundColor => Colors.grey.shade300.withOpacity(0.8);

  final String title;
  final String imageUrl;
  final List<Widget> additionalWidgets;
  final VoidCallback onTap;

  const ImageListTile({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.additionalWidgets = const [],
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                spreadRadius: 0,
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
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: ImageListTile.backgroundColor,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  ...additionalWidgets,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
