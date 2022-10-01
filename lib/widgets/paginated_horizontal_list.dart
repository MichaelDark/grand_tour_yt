import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/paginated_ui_resource.dart';

class PaginatedHorizontalList<T> extends StatelessWidget {
  final ItemWidgetBuilder<T> itemBuilder;
  final PagintatedUiResource<T, String?> pagintatedResource;

  const PaginatedHorizontalList({
    super.key,
    required this.pagintatedResource,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PagedListView(
        scrollDirection: Axis.horizontal,
        pagingController: pagintatedResource.controller,
        builderDelegate: PagedChildBuilderDelegate<T>(itemBuilder: itemBuilder),
      ),
    );
  }
}
