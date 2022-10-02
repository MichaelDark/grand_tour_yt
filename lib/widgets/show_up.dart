import 'dart:async';

import 'package:flutter/material.dart';

class ShowUp extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const ShowUp({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<StatefulWidget> createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    const duration = Duration(milliseconds: 500);
    _controller = AnimationController(vsync: this, duration: duration);

    final offsetTween =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero);
    final offsetAnimation =
        CurvedAnimation(curve: Curves.decelerate, parent: _controller);
    _offsetAnimation = offsetTween.animate(offsetAnimation);

    Timer(widget.delay, () => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _offsetAnimation,
        child: widget.child,
      ),
    );
  }
}
