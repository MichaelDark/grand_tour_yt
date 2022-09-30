import 'package:flutter/material.dart';

class ChannelImage extends StatelessWidget {
  final String imageUrl;

  const ChannelImage({super.key, required this.imageUrl});

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
        child: Image.network(
          imageUrl,
          height: 128,
          width: 128,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
