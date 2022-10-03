abstract class UiResource<T> {
  Future<T> get future;
  void retry();
}
