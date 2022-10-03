import 'dart:math';

extension IntExt on int {
  /// Formats large number
  /// ```
  /// 1200.formatCount()    // 1.2K
  /// 1210.formatCount()    // 1.21K
  /// 1211.formatCount()    // 1.21K
  /// 1200000.formatCount() // 1.2M
  /// 1210000.formatCount() // 1.21M
  /// 1211000.formatCount() // 1.21M
  /// ```
  String formatCount([int decimals = 2]) {
    const k = 1000;
    final dm = decimals < 0 ? 0 : decimals;
    const sizes = ['', 'K', 'M', 'B', 'T', 'Q'];

    final i = (log(this) / log(k)).floor();
    final digit = sizes[i];
    String text;

    if (i == 0) {
      text = '${this ~/ pow(k, i)}';
    } else {
      text = (this / pow(k, i)).toStringAsFixed(dm);
      String beforeDot = text.substring(0, text.indexOf('.'));
      String afterDot = text.substring(text.indexOf('.'), text.length);
      while (afterDot[afterDot.length - 1] == '0') {
        afterDot = afterDot.substring(0, afterDot.length - 1);
      }
      if (afterDot.length == 1) {
        text = beforeDot;
      } else {
        text = '$beforeDot$afterDot';
      }
    }

    return '$text$digit';
  }
}
