import 'package:flutter/material.dart';

import '../models/ui_resource.dart';
import 'error_view.dart';
import 'loading_view.dart';

class ResourceBuilder<T> extends StatefulWidget {
  final UiResource<T> resource;
  final Widget Function(BuildContext, T) builder;

  const ResourceBuilder({
    required this.resource,
    required this.builder,
    super.key,
  });

  @override
  State<ResourceBuilder<T>> createState() => _ResourceBuilderState<T>();
}

class _ResourceBuilderState<T> extends State<ResourceBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      key: ValueKey(widget.resource.future),
      future: widget.resource.future,
      builder: (context, snap) {
        if (snap.hasError) {
          return ErrorView(
            snap.error,
            retry: () => setState(() => widget.resource.retry()),
          );
        }
        if (snap.hasData) return widget.builder(context, snap.data as T);
        return const LoadingView();
      },
    );
  }
}
