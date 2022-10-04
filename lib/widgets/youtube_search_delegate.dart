import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../di/locator.dart';
import '../l10n/youtube_strings.dart';
import '../models/youtube/youtube_playlist_item.dart';
import '../services/search_query_repository.dart';
import '../view_models/view_model_factory.dart';
import 'slivers/sliver_paged_image_tile_list.dart';
import 'tiles/youtube_playlist_item_list_tile.dart';

class YoutubeSearchDelegate extends SearchDelegate {
  final String channelId;

  YoutubeSearchDelegate(this.channelId);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              YoutubeStrings.of(context).searchErrorMoreThenTwoSymbols,
            ),
          )
        ],
      );
    }

    final searchQueryService = locator<SearchQueryRepository>();
    searchQueryService.saveQuery(query);

    final viewModelFactory = locator<ViewModelFactory>();
    final viewModel = viewModelFactory.videoSearch(channelId, query);

    return CustomScrollView(
      slivers: [
        SliverPagedImageTileList<YoutubePlaylistItem>(
          resource: viewModel.searchResultResource,
          builder: (_, item, __) {
            return YoutubePlaylistItemListTile(playlistItem: item);
          },
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchQueryService = locator<SearchQueryRepository>();
    final cachedQueries = searchQueryService.getCachedQueries().toList();
    cachedQueries.sort((a, b) => b.searchedAt.compareTo(a.searchedAt));

    if (cachedQueries.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ...cachedQueries.map(
            (cachedQuery) {
              return ListTile(
                title: Text(cachedQuery.query),
                subtitle: Text(
                  timeago.format(
                    cachedQuery.searchedAt,
                    locale: Localizations.localeOf(context).toLanguageTag(),
                  ),
                ),
                onTap: () {
                  query = cachedQuery.query;
                },
              );
            },
          ),
        ],
      );
    }

    if (query.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              YoutubeStrings.of(context).searchErrorEmpty,
            ),
          )
        ],
      );
    }

    return Container();
  }
}
