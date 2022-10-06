# Grand Tour YT

__Summary__
- [Objective](#objective)
- [Get Started](#get-started)
    - [Packages overview](#packages-overview)
    - [API usage overview](#api-usage-overview)
    - [Project Structure overview](#project-structure-overview)
- [Appendix - CLI](#appendix---cli)

## Objective

- [x] Platforms
  - [x] iOS
  - [x] Android
- [x] APIs
  - [x] [Youtube Data API v3](https://developers.google.com/youtube/v3)
- [x] Features
  - [x] Fetch the latest videos from your favorite channel
  - [x] Retrieve all playlists from your favorite channel
  - [x] Retrieve all the videos from a playlist of your favorite channel
  - [x] Search for a video among all the videos of a that favorite channel
    - [x] Persist the user's search history
    - [x] Present the user's search history to the user
  - [x] Watch the selected Youtube video
    - [x] Either from a playlist or from the list of the latest videos of the channel.
- [x] It is **mandatory** to display at least the thumbnails and titles of the video/playlist/channel

UPD. Additional features, that are implemented:
- [x] App is fetching list of favorite channels, __not only a single one__
- [x] All View Models are granular lazy singletons
- [x] Supports fetching additional data (i.e. parts) from the Youtube Data API
- [x] Supports multiple languages
    - [x] English
    - [x] Ukrainian
    - [x] French
    - [x] Spanish
- [x] Supports multiple themes
    - [x] Dark
    - [x] Light
- [x] Supports full screen videos
- [x] Supports sorting of cached search queries by the time they were last used

## Getting Started

⚠️ ⚠️ ⚠️ **Warning!** Inorder to run this app, you need to use your own Firebase Project, that is walk through `google_sign_in` integration guide using your own Firebase Project. Youtube Data API should be enabled in Google Cloud Project that corresponds to your Firebase project

### Packages overview
App requires some core packages to establish the base project structure:
- `get_it` - used as a dependencies container for DI
- `injectable` - code gen for `get_it`, supports modules for 3rd party deps 
- `logger` - used for logging, injected using module
- `intl` - used for localizations and proper numbers formatting

For Google API (i.e. Youtube Data API v3) the app is using the following packages:
- `googleapis` - autogenerated Google APIs (including Youtube Data API v3)
- `google_sign_in` - required to authenticate the user for Google API requests
- `extension_google_sign_in_as_googleapis_auth` - required to create authenticated HTTP client for `googleapis`
- `http` - required to reference HTTP client in project according to linter
- `iso_duration_parser` - required to parse duration from `googleapis` responses

These packages are used for persestence:
- `hive`
- `hive_flutter`

The following packages are used for various UI purposes:
- `lottie` - for displaying efficient animations
- `infinite_scroll_pagination` - for displaying paginated responses
- `youtube_player_flutter` - for displaying videos
- `google_fonts` - for nice fonts :)
- `flutter_inset_box_shadow` - for inner shadow of the channel image
- `timeago` - for formatting elapsed time since a particular datetime
- `shimmer` - for displaying loading elements
- `flutter_localized_locales` - for language names
- `recase` - for changing the casing of texts
- `locale_emoji_flutter` - for displaying the emoji of the language

These packages are really useful, but are available only during development:
- `mocktail` - for testing (creating mocks)
- `hive_test` - for mocking `hive`/`hive_flutter`
- `flutter_lints` - for linting the project and maintain proper code quality, that matches industry standards
- `build_runner` - for code gen
- `injectable_generator` - for DI code gen
- `flutter_gen_runner` - for assets code gen

### API usage overview

For Youtube Data API, the requester must be authorized and [API should be enabled](https://developers.google.com/youtube/v3/getting-started). 
To authorize the user to view Youtube Data from the application, it is needed to have:
- Firebase Project - for `google_sign_in`
    - including `android/app/google-services.json`
    - including `ios/runner/GoogleService-Info.plist`
    - including Android debug keystore SHA-1 in Firebase Android App (for Android debug builds to be able to sign in using Google)
- Google Cloud Project (GCP, corresponding to the Firebase Project)

Here is the list of used APIs:
- [YouTube Data API (v3): Channels: list](https://developers.google.com/youtube/v3/docs/channels/list)
- [YouTube Data API (v3): Videos: list](https://developers.google.com/youtube/v3/docs/videos/list)
- [YouTube Data API (v3): Playlists: list](https://developers.google.com/youtube/v3/docs/playlists/list)
- [YouTube Data API (v3): PlaylistItems: list](https://developers.google.com/youtube/v3/docs/playlistItems/list)
- [YouTube Data API (v3): Search: list](https://developers.google.com/youtube/v3/docs/search/list)

### Project Structure overview

Structure
```
- LICENSE
- README.md
- analysis_options.yaml
- l10n.yaml
- pubspec.yaml
- pubspec.lock
- android               # Android native bridge.
- ios                   # IOS native bridge.
- web                   # Web native bridge.
- test                  # dir for tests, TBD.
- assets                # where all asset images/animations live.
- lib                   
    - di                # all related to DI.
        - modules       # all related to DI of 3rd party deps.
    - l10n              # all related to texts localizations.
    - models
        - db            # db related models.
        - resources     # models that are used for resource loading...
            - impl      # ...and their implementations.
        - youtube       # youtube API related models.
    - pages             # UI pages.
    - services          # various services...
        - impl          # ...and their implementations.
    - utils             # various utils, helper classes and extensions.
    - view_models       # various view models...
        - impl          # ...and their implementations.
    - widgets           # place where all widget live.
        - resources     # widgets that are related to resources.
        - slivers       # all complex or reused slivers.
        - tiles         # all complex or reused list tile.
```

## Appendix - CLI

Consider using this commands when working with the repository:

```bash
# Obviously. Getting dependencies
flutter pub get

# Generates YoutubeStrings class with localizations
flutter gen-l10n

# Generates Assets class and injectable dependencies initialization
flutter pub run build_runner build --delete-conflicting-outputs

# Generates SHA-1 hafh from the Android debug keystore
# for Firebase to allow Google Sign In in debug buils
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
```
