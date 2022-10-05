import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../youtube/youtube_response.dart';
import '../paginated_ui_resource.dart';

class PaginatedYoutubeUiResource<T> extends PaginatedUiResource<T> {
  @override
  final PagingController<String?, T> controller;

  PaginatedYoutubeUiResource(
    Future<YoutubeResponse<T>> Function(String? pageToken) request,
  ) : controller = PagingController(firstPageKey: null) {
    controller.addPageRequestListener((pageKey) async {
      try {
        final response = await request(pageKey);
        final newItems = response.items;
        final nextPageToken = response.nextPageToken;
        if (nextPageToken == null) {
          controller.appendLastPage(newItems);
        } else {
          controller.appendPage(newItems, nextPageToken);
        }
      } catch (e) {
        controller.error = e;
      }
    });
  }
}
