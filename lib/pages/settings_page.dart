import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:recase/recase.dart';

import '../di/locator.dart';
import '../l10n/youtube_strings.dart';
import '../services/settings_service.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsPage({Key? key}) : super(key: key);

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
                title: Text(YoutubeStrings.of(context).settingsPageThemeTitle),
                subtitle:
                    Text(YoutubeStrings.of(context).settingsPageThemeSubtitle),
                isThreeLine: true,
                onTap: () => settingsService.toggleBrightness(),
              ),
            ),
            SliverToBoxAdapter(
              child: PopupMenuButton<Locale>(
                child: ListTile(
                  leading: const Icon(Icons.language_rounded),
                  title: Text(settingsService.locale.getDisplayName(context)),
                  subtitle: Text(
                      YoutubeStrings.of(context).settingsPageLanguageSubtitle),
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
                        return PopupMenuItem<Locale>(
                          value: locale,
                          child: Text(
                            locale.getDisplayName(context),
                          ),
                        );
                      },
                    ),
                  ];
                },
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
