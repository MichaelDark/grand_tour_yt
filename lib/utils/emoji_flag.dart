import 'dart:ui' as ui;

import 'package:characters/characters.dart';

abstract class EmojiFlags {
  static String get whiteFlag => String.fromCharCodes([0xD83C, 0xDFF3]);
}

/// Thankfully taken from https://github.com/richardvenneman/emoji_flag/
extension EmojiFlagsLocaleExt on ui.Locale {
  static const _offset = 127397;

  String? get emojiFlag {
    final languageCode = this.languageCode;
    final countryCode = this.countryCode;

    String? emoji;
    emoji ??= _fromCountryCode(countryCode);
    emoji ??= _fromLanguageCode(languageCode);

    return emoji;
  }

  String? _fromCountryCode(String? code) {
    if (code == null || !RegExp(r"^[a-zA-Z]{2}$").hasMatch(code)) return null;
    final possibleFlag = _countryCodeToEmoji(code);
    if (_isEmojiCountyFlag(possibleFlag)) return possibleFlag;
    return null;
  }

  String? _fromLanguageCode(String languageCode) {
    String? code = _languageCodeToCountryCode[languageCode.toLowerCase()];
    if (code != null) return _countryCodeToEmoji(code);
    return null;
  }

  String _countryCodeToEmoji(String countryCode) {
    if (countryCode.isEmpty) return '';
    final upperCountryCode = countryCode.toUpperCase();
    final chars = upperCountryCode.characters;
    final offsetChars = chars.map((e) => e.runes.first + _offset);
    final emoji = String.fromCharCodes(offsetChars);
    return emoji;
  }

  /// Thankfully taken from https://stackoverflow.com/a/53360229
  bool _isEmojiCountyFlag(String emoji) {
    String s1 = String.fromCharCode(0xD83C);
    String s21 = String.fromCharCode(0xDDE6);
    String s22 = String.fromCharCode(0xDDFF);
    String s3 = String.fromCharCode(0xD83C);
    String s41 = String.fromCharCode(0xDDE6);
    String s42 = String.fromCharCode(0xDDFF);
    String symbol1 = r'[' + s1 + r']';
    String symbol2 = r'[' + s21 + r'-' + s22 + r']';
    String symbol3 = r'[' + s3 + r']';
    String symbol4 = r'[' + s41 + r'-' + s42 + r']';
    String pattern = r'^' + symbol1 + symbol2 + symbol3 + symbol4 + r'$';

    return RegExp(pattern).hasMatch(emoji);
  }
}

/// Default correspondence between language code and country code
///
/// Thankfully taken from https://github.com/10xjs/locale-emoji
const Map<String, String> _languageCodeToCountryCode = {
  'af': 'ZA',
  'agq': 'CM',
  'ak': 'GH',
  'am': 'ET',
  'ar': 'AE',
  'as': 'IN',
  'asa': 'TZ',
  'az': 'AZ',
  'bas': 'CM',
  'be': 'BY',
  'bem': 'ZM',
  'bez': 'IT',
  'bg': 'BG',
  'bm': 'ML',
  'bn': 'BD',
  'bo': 'CN',
  'br': 'FR',
  'brx': 'IN',
  'bs': 'BA',
  'ca': 'ES',
  'cgg': 'UG',
  'chr': 'US',
  'cs': 'CZ',
  'cy': 'GB',
  'da': 'DK',
  'dav': 'KE',
  'de': 'DE',
  'dje': 'NE',
  'dua': 'CM',
  'dyo': 'SN',
  'ebu': 'KE',
  'ee': 'GH',
  'en': 'GB',
  'el': 'GR',
  'es': 'ES',
  'et': 'EE',
  'eu': 'ES',
  'ewo': 'CM',
  'fa': 'IR',
  'fil': 'PH',
  'fr': 'FR',
  'ga': 'IE',
  'gl': 'ES',
  'gsw': 'CH',
  'gu': 'IN',
  'guz': 'KE',
  'gv': 'GB',
  'ha': 'NG',
  'haw': 'US',
  'he': 'IL',
  'hi': 'IN',
  'ff': 'CN',
  'fi': 'FI',
  'fo': 'FO',
  'hr': 'HR',
  'hu': 'HU',
  'hy': 'AM',
  'id': 'ID',
  'ig': 'NG',
  'ii': 'CN',
  'is': 'IS',
  'it': 'IT',
  'ja': 'JP',
  'jmc': 'TZ',
  'ka': 'GE',
  'kab': 'DZ',
  'ki': 'KE',
  'kam': 'KE',
  'mer': 'KE',
  'kde': 'TZ',
  'kea': 'CV',
  'khq': 'ML',
  'kk': 'KZ',
  'kl': 'GL',
  'kln': 'KE',
  'km': 'KH',
  'kn': 'IN',
  'ko': 'KR',
  'kok': 'IN',
  'ksb': 'TZ',
  'ksf': 'CM',
  'kw': 'GB',
  'lag': 'TZ',
  'lg': 'UG',
  'ln': 'CG',
  'lt': 'LT',
  'lu': 'CD',
  'lv': 'LV',
  'luo': 'KE',
  'luy': 'KE',
  'mas': 'TZ',
  'mfe': 'MU',
  'mg': 'MG',
  'mgh': 'MZ',
  'ml': 'IN',
  'mk': 'MK',
  'mr': 'IN',
  'ms': 'MY',
  'mt': 'MT',
  'mua': 'CM',
  'my': 'MM',
  'naq': 'NA',
  'nb': 'NO',
  'nd': 'ZW',
  'ne': 'NP',
  'nl': 'NL',
  'nmg': 'CM',
  'nn': 'NO',
  'nus': 'SD',
  'nyn': 'UG',
  'om': 'ET',
  'or': 'IN',
  'pa': 'PK',
  'pl': 'PL',
  'ps': 'AF',
  'pt': 'PT',
  'rm': 'CH',
  'rn': 'BI',
  'ro': 'RO',
  'ru': 'RU',
  'rw': 'RW',
  'rof': 'TZ',
  'rwk': 'TZ',
  'saq': 'KE',
  'sbp': 'TZ',
  'seh': 'MZ',
  'ses': 'ML',
  'sg': 'CF',
  'shi': 'MA',
  'si': 'LK',
  'sk': 'SK',
  'sl': 'SI',
  'sn': 'ZW',
  'so': 'SO',
  'sq': 'AL',
  'sr': 'RS',
  'sv': 'SE',
  'sw': 'TZ',
  'swc': 'CD',
  'ta': 'IN',
  'te': 'IN',
  'teo': 'UG',
  'th': 'TH',
  'ti': 'ER',
  'to': 'TO',
  'tr': 'TR',
  'twq': 'NE',
  'tzm': 'MA',
  'uk': 'UA',
  'ur': 'PK',
  'uz': 'UZ',
  'vai': 'LR',
  'vi': 'VN',
  'vun': 'TZ',
  'xog': 'UG',
  'yav': 'CM',
  'yo': 'NG',
  'zh': 'CN',
  'zu': 'ZA'
};
