import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

abstract class PagintatedUiResource<T, TKey> {
  PagingController<TKey, T> get controller;
}

class YoutubePagintatedUiResource<T, TResponse>
    extends PagintatedUiResource<T, String?> {
  @override
  final PagingController<String?, T> controller;

  YoutubePagintatedUiResource(
    Future<TResponse> Function(String? pageToken) request, {
    required String? Function(TResponse) nextPageTokenExtractor,
    required List<T> Function(TResponse) listExtractor,
  }) : controller = PagingController(firstPageKey: null) {
    controller.addPageRequestListener((pageKey) async {
      try {
        final response = await request(pageKey);
        final newItems = listExtractor(response);
        final nextPageToken = nextPageTokenExtractor(response);
        if (nextPageToken == null) {
          controller.appendLastPage(newItems);
        } else {
          controller.appendPage(newItems, nextPageToken);
        }
      } catch (error) {
        controller.error = error;
      }
    });
  }
}
