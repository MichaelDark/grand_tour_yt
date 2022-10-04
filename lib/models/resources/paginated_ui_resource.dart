import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

abstract class PaginatedUiResource<T> {
  PagingController<String?, T> get controller;
}
