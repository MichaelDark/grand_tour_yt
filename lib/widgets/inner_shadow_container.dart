import 'package:flutter/material.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart'
    as inset_shadow;

class ImageInnerShadow extends StatelessWidget {
  final Widget? child;

  const ImageInnerShadow({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const inset_shadow.BoxDecoration(
        boxShadow: [
          inset_shadow.BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 64,
            spreadRadius: 16,
            color: Colors.black,
            inset: true,
          ),
        ],
      ),
      child: child,
    );
  }
}
