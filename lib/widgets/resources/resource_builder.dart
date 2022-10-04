import 'package:flutter/material.dart';

import '../../models/resources/ui_resource.dart';
import 'error_view.dart';
import 'loading_view.dart';

class ResourceBuilder<T> extends StatefulWidget {
  final UiResource<T> resource;
  final Widget Function(BuildContext, T) builder;
  final Widget Function(BuildContext)? loadingBuilder;
  final Widget Function(BuildContext, dynamic, VoidCallback)? errorBuilder;

  const ResourceBuilder({
    required this.resource,
    required this.builder,
    this.loadingBuilder,
    this.errorBuilder,
    super.key,
  });

  @override
  State<ResourceBuilder<T>> createState() => _ResourceBuilderState<T>();
}

class _ResourceBuilderState<T> extends State<ResourceBuilder<T>> {
  void _retry() {
    setState(() {
      widget.resource.retry();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      key: ValueKey(widget.resource.future),
      future: widget.resource.future,
      builder: (context, snap) {
        if (snap.hasError) {
          return widget.errorBuilder?.call(context, snap.error, _retry) ??
              ErrorView(snap.error, retry: _retry);
        }
        if (snap.hasData) {
          return widget.builder(context, snap.data as T);
        }

        return widget.loadingBuilder?.call(context) ?? const LoadingView();
      },
    );
  }
}
