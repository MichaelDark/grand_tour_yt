abstract class UiResource<T> {
  Future<T> get future;
  void retry();
}

class FutureUiResource<T> extends UiResource<T> {
  final Future<T> Function() _load;

  FutureUiResource(this._load) : future = _load();

  @override
  Future<T> future;

  @override
  void retry() => future = _load();
}
