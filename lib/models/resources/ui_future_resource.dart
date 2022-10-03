import 'dart:async';

import 'ui_resource.dart';

typedef UiResourceLoader<T> = Future<T> Function();

class UiFutureResource<T> extends UiResource<T> {
  final UiResourceLoader<T> _load;

  UiFutureResource(this._load) : future = _load();

  @override
  Future<T> future;

  @override
  void retry() => future = _load();
}
