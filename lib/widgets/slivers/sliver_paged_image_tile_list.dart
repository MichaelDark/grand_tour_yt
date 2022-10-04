import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../models/resources/paginated_ui_resource.dart';
import '../tiles/image_list_tile_error.dart';
import '../tiles/image_list_tile_shimmer.dart';

class SliverPagedImageTileList<T> extends SliverPadding {
  final PaginatedUiResource<T> resource;
  final ItemWidgetBuilder builder;

  SliverPagedImageTileList({
    Key? key,
    EdgeInsets padding = const EdgeInsets.all(16),
    required this.resource,
    required this.builder,
  }) : super(
          key: key,
          padding: padding,
          sliver: PagedSliverList(
            pagingController: resource.controller,
            builderDelegate: PagedChildBuilderDelegate<T>(
              animateTransitions: true,
              itemBuilder: builder,
              newPageProgressIndicatorBuilder: (context) {
                return const ImageListTileShimmer();
              },
              firstPageProgressIndicatorBuilder: (context) {
                return const ImageListTileShimmer();
              },
              firstPageErrorIndicatorBuilder: (context) {
                return ImageListTileError(
                  error: resource.controller.error,
                  retry: resource.controller.retryLastFailedRequest,
                );
              },
              newPageErrorIndicatorBuilder: (context) {
                return ImageListTileError(
                  error: resource.controller.error,
                  retry: resource.controller.retryLastFailedRequest,
                );
              },
            ),
          ),
        );
}
