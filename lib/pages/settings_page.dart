import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:recase/recase.dart';

import '../di/locator.dart';
import '../l10n/youtube_strings.dart';
import '../services/search_query_repository.dart';
import '../services/settings_service.dart';
import '../utils/emoji_flag.dart';
import '../widgets/clear_history_confirmation_dialog.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsPage({Key? key}) : super(key: key);

  void _onClearSearchHistory(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (_) => const ClearHistoryConfirmationDialog(),
    );

    if (result == true) {
      final searchQueryService = locator<SearchQueryRepository>();
      await searchQueryService.clearCachedQueries();
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsService = locator<SettingsService>();

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(YoutubeStrings.of(context).settingsPageTitle),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: ListTile(
                leading: const Icon(Icons.palette_rounded),
                title: Text(
                  YoutubeStrings.of(context).settingsPageThemeTitle,
                ),
                subtitle: Text(
                  YoutubeStrings.of(context).settingsPageThemeSubtitle,
                ),
                isThreeLine: true,
                onTap: () => settingsService.toggleBrightness(),
              ),
            ),
            SliverToBoxAdapter(
              child: PopupMenuButton<Locale>(
                child: ListTile(
                  leading: const Icon(Icons.language_rounded),
                  title: Text(
                    settingsService.locale.getDisplayName(context),
                  ),
                  subtitle: Text(
                    YoutubeStrings.of(context).settingsPageLanguageSubtitle,
                  ),
                  isThreeLine: true,
                ),
                onSelected: (Locale? pickedLocale) {
                  if (pickedLocale == null) return;
                  settingsService.setLocale(pickedLocale);
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<Locale>>[
                    ...YoutubeStrings.supportedLocales.map(
                      (locale) {
                        final emojiFlag = locale.emojiFlag;
                        final prefix = emojiFlag == null ? '' : '$emojiFlag  ';
                        final displayName = locale.getDisplayName(context);

                        return PopupMenuItem<Locale>(
                          value: locale,
                          child: Text('$prefix$displayName'),
                        );
                      },
                    ),
                  ];
                },
              ),
            ),
            SliverToBoxAdapter(
              child: ListTile(
                leading: const Icon(Icons.auto_delete_rounded),
                title: Text(
                  YoutubeStrings.of(context)
                      .settingsPageClearSearchHistoryTitle,
                ),
                subtitle: Text(
                  YoutubeStrings.of(context)
                      .settingsPageClearSearchHistorySubtitle,
                ),
                isThreeLine: true,
                onTap: () => _onClearSearchHistory(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on Locale {
  String getDisplayName(BuildContext context) {
    final languageTag = toLanguageTag();
    final name = LocaleNames.of(context)!.nameOf(languageTag) ?? languageTag;
    return name.titleCase;
  }
}
