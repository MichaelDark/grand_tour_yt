import 'ui_resource.dart';

class UiFutureResource<T> extends UiResource<T> {
  final Future<T> Function() _load;

  UiFutureResource(this._load) : future = _load();

  @override
  Future<T> future;

  @override
  void retry() => future = _load();
}
